class ConnectionsController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    
  def index
      @kinds = Kind.all.order(kind: "ASC")
      @stages = Stage.all.order(stage: "ASC")
      @connections = Connection.all
  end

  def update
      
      @connection = Connection.find_by(id: params[:id])
      
      @connection.invalid_flag = !@connection.invalid_flag
      
      if @connection.save
          flash[:notice] = "反転が完了しました"
          redirect_to("/connections")
      else
          render  'index'
      end
    
  end
       
end
