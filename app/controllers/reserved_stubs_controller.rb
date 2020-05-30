class ReservedStubsController < ApplicationController
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
    
    case params[:order_id]
    when 'order_by_seller_id_and_buyer_furigana' then
        if current_seller.admin_flag
            @tickets = Ticket.where(stage_id: params[:stage_id])
                          .includes(:seller).order("sellers.name asc").order(buyer_furigana: "ASC")
        else
          @tickets = Ticket.where(stage_id: params[:stage_id], seller_id: current_seller.id)
                         .includes(:seller).order("sellers.name asc").order(buyer_furigana: "ASC")
        end
    when 'order_by_buyer_furigana' then
        if current_seller.admin_flag
            @tickets = Ticket.where(stage_id: params[:stage_id])
                          .order(buyer_furigana: "ASC")
        else
            @tickets = Ticket.where(stage_id: params[:stage_id], seller_id: current_seller.id)
                          .order(buyer_furigana: "ASC")
        end
    when 'order_by_created_at' then
        if current_seller.admin_flag
            @tickets = Ticket.where(stage_id: params[:stage_id])
                          .order(created_at: "DESC")
        else
            @tickets = Ticket.where(stage_id: params[:stage_id], seller_id: current_seller.id)
                          .order(created_at: "DESC")
        end
    end
end

end
