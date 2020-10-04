class SellersController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    #『公演』モデルの各レコードの受付終了時間が現在時間と同じ時間、若しくは過ぎていれば、終了フラグを立てる
    before_action :end_time_past?

    
    def index
        
        @host_with_port = request.host_with_port
        if current_seller.admin_flag?
            @sellers = Seller.all
            @sellers = Seller.where(id: current_seller.id)
        end
    end

    def edit
        @seller = Seller.find(params[:id])
    end

    def update
        @subdomain = request.subdomain.to_s.to_sym
        @seller = Seller.find(params[:id])
        @seller.assign_attributes(params_seller)
        
        if params[:Sakujyo]
            
            if Ticket.where(seller_id: @seller.id).exists?
                flash[:alert] = "『取扱者』を削除する前に、削除したい『取扱者』を使用している『チケット』を削除してください。"
            else
                @seller.destroy
            end

            redirect_to("/sellers")

         else
          
            if @seller.save
                UserMailer.with(subdomain: subdomain).notice_mail_for_update_seller(@seller).deliver
                flash[:notice] = "編集が完了しました"
                if @seller.id == current_seller.id && @seller.admin_flag == false
                    redirect_to("/sellers/sign_out")
                else
                    redirect_to("/sellers")
                end
                
          end
            
        end
        
    end
    
    def mail_all
            @subdomain = request.subdomain.to_s.to_sym
            @sellers = Seller.where(id: params[:sellers])
            @host_with_port = request.host_with_port
            
            @sellers.each do |seller|
                seller.url = "https://#{@host_with_port}/registers/#{seller.id}/new"
                seller.save
            end
            
            
            @sellers.each do |seller|
              UserMailer.with(subdomain: subdomain).notice_mail_for_url(seller).deliver
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

        redirect_to("/sellers")
    end
    
    private
    def params_seller
     params.require(:seller).permit(:admin_flag, :url, :rental_tickets)
    end
    
end
