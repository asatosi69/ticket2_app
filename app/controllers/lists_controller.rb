class ListsController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
      
    def index
        @sellers = Seller.all
        @stages = Stage.all.order(stage: "ASC")
        @kinds = Kind.all.order(kind: "ASC")
        @payments = Payment.all.order(payment: "ASC")
        @tickets = Ticket.all
    end
end
