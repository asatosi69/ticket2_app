class ConnectionsController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    
  def index
      @kinds = Kind.all.order(kind: "ASC")
      @stages = Stage.all.order(stage: "ASC")
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
