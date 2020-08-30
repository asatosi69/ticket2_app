class ReservedListsController < ApplicationController
  # ログインしているユーザーのみ操作できるようにする
  before_action :authenticate_seller!
  # 『管理者』として、ログインしないと処理は実行できない
  before_action :admin_seller?

  def index
        @stages = Stage.all.order(stage_time: "ASC")
        @kinds = Kind.all.order(kind: "ASC")
  end

  def reserved_list_print
      @page_title = '予約一覧別ウィンドウ'
      search_condition = Ticket.joins(:seller).where(stage_id: params[:stage_id])
      search_condition =
          case params[:order_id]
               when 'order_by_seller_id_and_buyer_furigana' then
                    search_condition.includes(:seller).order("sellers.name asc").order(buyer_furigana: "ASC")
               when 'order_by_buyer_furigana' then
                    search_condition.order(buyer_furigana: "ASC")
               when 'order_by_created_at' then
                    search_condition.order(created_at: "DESC")
          end
      @stage = Stage.find_by(id: params[:stage_id])
      @tickets = search_condition
      #render template: 'reserved_lists/reserved_lists'
      render 'reserved_lists/reserved_lists', layout: "application2" and return
    end

end
