class Connections2Controller < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    
  def index
      @kinds = Kind.all.order(kind: "ASC")
      @payments = Payment.all.order(payment: "ASC")
      @connections = Connection2.all
  end

  def connection2_all
        
        @connections = Connection2.where(id: params[:connections])

        @connections.each do |connection|
          connection.invalid_flag = !connection.invalid_flag
          connection.save
        end
        
        redirect_to("/connections")
  end
       
end