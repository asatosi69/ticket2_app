class VisitorsController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!

  def index
      @stages = Stage.all.order(stage: "ASC")
      @kinds = Kind.all.order(kind: "ASC")
      
      if current_seller.admin_flag
        @sellers = Seller.all
      else
        @sellers = Seller.where(id: current_seller.id)
      end
      
      if params[:order_id] == 'order_by_seller_id_and_buyer_furigana'
        if current_seller.admin_flag
          @tickets = Ticket.where(stage_id: params[:stage_id])
                           .includes(:seller).order("sellers.name asc").order(buyer_furigana: "ASC")
        else
          @tickets = Ticket.where(stage_id: params[:stage_id], seller_id: current_seller.id)
                           .includes(:seller).order("sellers.name asc").order(buyer_furigana: "ASC")
        end
      else
        if current_seller.admin_flag
          @tickets = Ticket.where(stage_id: params[:stage_id])
                           .order(buyer_furigana: "ASC")
        else
          @tickets = Ticket.where(stage_id: params[:stage_id], seller_id: current_seller.id)
                           .order(buyer_furigana: "ASC")
        end
      end
  end


  def visitor_all
        
        @tickets = Ticket.where(id: params[:tickets])
        
        validation_context = current_seller.admin_flag? ? :admin_seller : nil
        
        @tickets.each do |ticket|
          ticket.visited_flag = !ticket.visited_flag
          ticket.save(context: validation_context)
        end
        
        redirect_to("/visitors")
  end
  
  def enquete
        @tickets = Ticket.all
        @tickets.each do |ticket|
            
          if ticket.visited_flag
            UserMailer.notice_mail_for_enquete(ticket).deliver
          end
        end
        
        redirect_to("/visitors")
  end

end
