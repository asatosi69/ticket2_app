class PaymentsController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    # 『管理取扱者』と『一般取扱者』では操作できる内容が異なる。『一般取扱者』は操作不可。
    before_action :admin_seller?
    
    def index
        @payments = Payment.all
    end

    def new
        @payment = Payment.new
    end

    def create
        @payment = Payment.new(params_payment)

        if @payment.save
            flash[:notice] = "登録が完了しました"
            redirect_to("/payments")
        else
            render  'new'
        end
    
    end

    def edit
        @payment = Payment.find_by(id: params[:id])
    end

    def update
        @payment = Payment.find_by(id: params[:id])
        @payment.assign_attributes(params_payment)
        
        if @payment.save
            flash[:notice] = "編集が完了しました"
            redirect_to("/payments")
        else
            render  'edit'
        end
    end
    
    def destroy
        @payment = Payment.find_by(id: params[:id])
        
         # 『支払方法』のレコードを削除する前に、削除対象のidが『チケットモデル』使用されていないかの確認をする
        if Ticket.where(payment_id: @payment.id).exists?
            flash[:alert] = "『支払方法』を削除する前に、削除したい『支払方法』を使用している『チケット』を削除してください。"
        else
            @payment.destroy
        end
      
        redirect_to("/payments")
    end
    
    private
     def params_payment
      params.require(:payment).permit(:payment, :abbreviation, :discount_rate)
     end
end
