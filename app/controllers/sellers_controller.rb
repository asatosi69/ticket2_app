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
    end
    
    def show
    end
    
    def update
        @seller = Seller.find_by(id: params[:id])
        @seller.admin_flag = !@seller.admin_flag
        
        if @seller.save
            flash[:notice] = "編集が完了しました"
            redirect_to("/sellers")
        else
            render  'edit'
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
    
end
