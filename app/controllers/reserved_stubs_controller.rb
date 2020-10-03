class ReservedStubsController < ApplicationController
  # ログインしているユーザーのみ操作できるようにする
  before_action :authenticate_seller!
  # 『管理者』として、ログインしないと処理は実行できない
  before_action :admin_seller?

  def index
    @stages = Stage.all.order(stage_time: "ASC")
    @kinds = Kind.all.order(kind: "ASC")
  end
  
  def reserved_stub_print
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
       when 'order_by_published_and_buyer_furigana' then
            search_condition.order(published: "DESC").order(buyer_furigana: "ASC")
       end
    @stage = Stage.find_by(id: params[:stage_id])
    @tickets = search_condition
    @tickets = @tickets.to_a
    while @tickets.size % (3 * 6) != 0
      @tickets << Ticket.new
    end
    
    if @tickets.count >= 1
      #render template: 'reserved_stubs/reserved_stubs'
      render 'reserved_stubs/reserved_stubs', layout: "application2"
    else
      render :index
      flash[:alert] = "出力対象となるデータが存在しません。"
    end
    
  end

end
