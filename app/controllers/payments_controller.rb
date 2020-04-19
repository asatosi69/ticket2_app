class PaymentsController < ApplicationController
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

        @payment.save
        redirect_to("/payments")
    end

    def edit
        @payment = Payment.find_by(id: params[:id])
    end

    def update
        @payment = Payment.find_by(id: params[:id])
        @payment.assign_attributes(params_payment)
        
        @payment.save
        redirect_to("/payments")
    end
    
    def destroy
        @payment = Payment.find_by(id: params[:id])
        
        # 『チケット種別モデル』のレコードを削除する前に、削除対象のidが『チケットモデル』使用されていないかの確認をする
        @payment.payment_id_already_deleted?
        
        @payment.destroy
        
        redirect_to("/payments")
    end
    
    private
     def params_payment
      params.require(:payment).permit(:payment, :abbreviation, :discount_rate)
     end
end
