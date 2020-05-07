class VisitorsController < ApplicationController
  def index
      @stages = Stage.all.order(stage: "ASC")
      
      
      if params[:order_id] == 'order_by_seller_id_and_buyer_furigana'
          binding.pry
        if current_seller.admin_flag
          @tickets = Ticket.where(stage_id: params[:stage_id])
                           .includes(:seller).order("sellers.name asc").order(buyer_furigana: "ASC")
        else
          @tickets = Ticket.where(stage_id: params[:stage_id], seller_id: current_seller.id)
                           .includes(:seller).order("sellers.name asc").order(buyer_furigana: "ASC")
        end
      else
      binding.pry
        if current_seller.admin_flag
          @tickets = Ticket.where(stage_id: params[:stage_id])
                           .order(buyer_furigana: "ASC")
        else
          @tickets = Ticket.where(stage_id: params[:stage_id], seller_id: current_seller.id)
                           .order(buyer_furigana: "ASC")
        end
      end
  end


  def update
  end
end
