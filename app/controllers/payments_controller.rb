class PaymentsController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    # 『管理者』として、ログインしないと処理は実行できない
    before_action :admin_seller?
    
    def index
        @payments = Payment.all
        @kinds = Kind.all
    end

    def new
        @payment = Payment.new
    end

    def create
        @payment = Payment.new(params_payment)
        
        # モデル『Connection2』に新しい『@payment』の情報を登録するための処理
        @kinds = Kind.all
        @kinds.each do |kind|
            @payment.kinds << kind
        end
        
        # モデル『Connection3』に新しい『@payment』の情報を登録するための処理
        @stages = Stage.all
        @stages.each do |stage|
            @payment.stages << stage
        end

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
      params.require(:payment).permit(:payment, :abbreviation, :discount_rate, :discount_keyword)
     end
end
