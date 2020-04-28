class SellersController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    
    def index
        if current_seller.admin_flag?
            @sellers = Seller.all
        else
            @sellers = Seller.where(id: current_seller.id)
        end
    end
    
    def create
    end
    
    def new
    end
    
    def edit
        @seller = Seller.find(params[:id])
    end
    
    def show
    end
    
    def update
        @seller = Seller.find(params[:id])
        @seller.assign_attributes(params_seller)
        
        if @seller.save
            UserMailer.notice_mail_for_url(@seller).deliver
            flash[:notice] = "編集が完了しました"
            redirect_to("/sellers")
        else
            redirect_to("/sellers")
        end
    end
    
    def destroy
        @seller = Seller.find_by(id: params[:id])
        
        # 『取扱者』のレコードを削除する前に、削除対象のidが『チケットモデル』使用されていないかの確認をする
        if Ticket.where(seller_id: @seller.id).exists?
            flash[:alert] = "『取扱者』を削除する前に、削除したい『取扱者』を使用している『チケット』を削除してください。"
        else
            @seller.destroy
        end
        
        @seller.destroy
        
        redirect_to("/sellers")
    end
    
    private
    def params_seller
     params.require(:seller).permit(:name, :admin_flag, :url)
    end
    
end
