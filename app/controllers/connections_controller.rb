class ConnectionsController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    # 『管理者』として、ログインしないと処理は実行できない
    before_action :admin_seller?
    
  def index
      @stages = Stage.all.order(stage_time: "ASC")
      @kinds = Kind.all.order(kind: "ASC")
      @connections = Connection.all
  end

  def connection_all
        
        @connections = Connection.where(id: params[:connections])

        @connections.each do |connection|
          connection.invalid_flag = !connection.invalid_flag
          connection.save
        end
        
        redirect_to("/connections")
  end
       
end
