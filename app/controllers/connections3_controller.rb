class Connections3Controller < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    
  def index
      @payments = Payment.all.order(payment: "ASC")
      @stages = Stage.all.order(stage: "ASC")
      @connections = Connection3.all
  end

  def connection3_all
        
        @connections = Connection3.where(id: params[:connections])

        @connections.each do |connection|
          connection.invalid_flag = !connection.invalid_flag
          connection.save
        end
        
        redirect_to("/connections")
  end
       
end
