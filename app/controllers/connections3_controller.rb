class Connections3Controller < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    # 『管理者』として、ログインしないと処理は実行できない
    before_action :admin_seller?
    
  def index
      @payments = Payment.all.order(payment: "ASC")
      @stages = Stage.all.order(stage_time: "ASC")
      @connections = Connection3.all
  end

  def connection3_all
        
        @connections = Connection3.where(id: params[:connections])

        @connections.each do |connection|
          connection.invalid_flag = !connection.invalid_flag
          connection.save
        end
        
        redirect_to("/connections3")
  end
       
end
