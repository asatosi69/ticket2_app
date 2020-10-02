class ListsController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
      
    def index
        
        if current_seller.admin_flag
          @sellers = Seller.all
        else
          @sellers = Seller.where(id: current_seller.id)
        end
    
        @stages = Stage.all.order(stage_time: "ASC")
        @kinds = Kind.all.order(kind: "ASC")
        @payments = Payment.all.order(discount_rate: "DESC")
        @tickets = Ticket.all
    end
end
