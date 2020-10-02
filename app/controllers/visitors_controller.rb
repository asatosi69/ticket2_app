class VisitorsController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!

  def index
      @stages = Stage.all.order(stage_time: "ASC")
      @kinds = Kind.all.order(kind: "ASC")

      if current_seller.admin_flag
        @sellers = Seller.all
      else
        @sellers = Seller.where(id: current_seller.id)
      end

      case params[:order_id]
      when 'order_by_seller_id_and_buyer_furigana' then
          if current_seller.admin_flag
              @tickets = Ticket.eager_load(:seller, :stage, :kind, :payment).where(stage_id: params[:stage_id])
                            .order("sellers.name asc").order(buyer_furigana: "ASC")
          else
              @tickets = Ticket.eager_load(:seller, :stage, :kind, :payment).where(stage_id: params[:stage_id], seller_id: current_seller.id)
                            .order("sellers.name asc").order(buyer_furigana: "ASC")
          end
      when 'order_by_buyer_furigana' then
          if current_seller.admin_flag
              @tickets = Ticket.eager_load(:seller, :stage, :kind, :payment).where(stage_id: params[:stage_id])
                            .order(buyer_furigana: "ASC")
          else
              @tickets = Ticket.eager_load(:seller, :stage, :kind, :payment).where(stage_id: params[:stage_id], seller_id: current_seller.id)
                            .order(buyer_furigana: "ASC")
          end
      when 'order_by_created_at' then
          if current_seller.admin_flag
              @tickets = Ticket.eager_load(:seller, :stage, :kind, :payment).where(stage_id: params[:stage_id])
                            .order(created_at: "DESC")
          else
              @tickets = Ticket.eager_load(:seller, :stage, :kind, :payment).where(stage_id: params[:stage_id], seller_id: current_seller.id)
                            .order(created_at: "DESC")
          end
      when 'order_by_published_and_buyer_furigana' then
          if current_seller.admin_flag
              @tickets = Ticket.eager_load(:seller, :stage, :kind, :payment).where(stage_id: params[:stage_id])
                            .order(published: "DESC").order(buyer_furigana: "ASC")
          else
              @tickets = Ticket.eager_load(:seller, :stage, :kind, :payment).where(stage_id: params[:stage_id], seller_id: current_seller.id)
                            .order(published: "DESC").order(buyer_furigana: "ASC")
          end
      end

      render 'visitors/index', layout: "application"
  end


  def visitor

        if params[:Hanten]

            @tickets = Ticket.where(id: params[:tickets])

            validation_context = current_seller.admin_flag? ? :admin_seller : nil

            @tickets.each do |ticket|
                ticket.visited_flag = !ticket.visited_flag
                ticket.save(context: validation_context)
            end

        else
        
          @tickets = Ticket.all
            enquete_array = [] #アンケート送付済みのメールアドレスを格納する配列

            @tickets.each do |ticket|
                if ticket.visited_flag # 来場済みか？
                    if ticket.buyer_mail.present? # メールアドレスが登録されているか？
                        binding.pry
                        if not ticket.enquete_flag # アンケート送付済みフラグが立っていないか？
                            binding.pry
                            unless enquete_array.include?(ticket.buyer_mail) # すでに同じメールアドレスについて処理をしていないか？
                                UserMailer.with(subdomain: subdomain).notice_mail_for_enquete(ticket).deliver
                                enquete_array.push(ticket.buyer_mail)
                            end
                            ticket.update(enquete_flag: true)
                        end
                    end
                end
            end

        end

        redirect_to("/visitors")
  end

end
