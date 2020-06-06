class SellersController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    #『公演』モデルの各レコードの受付終了時間が現在時間と同じ時間、若しくは過ぎていれば、終了フラグを立てる
    before_action :end_time_past?

    
    def index
        
        @host_with_port = request.host_with_port
        if current_seller.admin_flag?
            @sellers = Seller.page(params[:page]).per(10)
        else
            @sellers = Seller.where(id: current_seller.id).page(params[:page]).per(10)
        end
    end

    
    def update
        @seller = Seller.find(params[:id])
        @seller.admin_flag = !@seller.admin_flag
        
        if @seller.save
            flash[:notice] = "フラグを反転させました"
            redirect_to("/sellers")
        else
            redirect_to("/sellers")
        end
    end
    
    def mail_all
        
        @sellers = Seller.where(id: params[:sellers])
        
        @sellers.each do |seller|
          UserMailer.notice_mail_for_url(seller).deliver
        end
  
        redirect_to("/sellers")

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
     params.require(:seller).permit(:admin_flag, :url)
    end
    
end
