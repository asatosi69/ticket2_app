class RegistersController < ApplicationController
      #『公演』モデルの各レコードの受付終了時間が現在時間と同じ時間、若しくは過ぎていれば、終了フラグを立てる
      before_action :end_time_past?
      # チケットレコードを作成するの必要なマスタ(『公演』/『チケット種別』/『支払方法』)のレコードが存在するのか確認する
      before_action :master_record2?
      # 予約数が『公演』モデルの各レコードの総席数と同じ、若しくは上回った場合、終了フラグを立てる
      before_action :sold_out?
      # 予約数が『公演』モデルの各レコードの総席数と同じ、若しくは上回った場合、終了フラグを立てる
      after_action :sold_out?, {only: [:create]}
      
      layout 'application2.html.erb'

      
    def new
        @seller = Seller.find(params[:seller_id])
        @subdomain = request.subdomain.to_s.to_sym
        @ticket = Ticket.new
    end
    
    def confirm
        @seller = Seller.find(params[:seller_id])
        @ticket = Ticket.new(params_ticket)

        return if @ticket.valid?

        render :new
    end
    
    def back
        @seller = Seller.find(params[:seller_id])
        @ticket = Ticket.new(params_ticket)

        render :new
    end

    def create
        @ticket = Ticket.new(params_ticket)
        seller_id = @ticket.seller_id
        validation_context = Seller.find(seller_id).admin_flag? ? :admin_seller : nil
        
        check = 0
           
        unless @ticket.payment.discount_keyword.empty?
           
            keywords = @ticket.payment.discount_keyword.split(",")
        
            for keyword in keywords do
                check = 1  if @ticket.comment1.include?(keyword)
            end

            if check == 1
                if @ticket.save
                    UserMailer.with(subdomain: subdomain).notice_mail_for_create_ticket(@ticket).deliver
                    flash[:notice] = "登録が完了しました"
                    redirect_to("/registers/#{seller_id}/thankyou")
                end
            else
                flash[:notice] = "割引キーワードが正しくありません。"
                redirect_to("/registers/#{seller_id}/new")
            end
            
        else
        
          if @ticket.save
              UserMailer.with(subdomain: subdomain).notice_mail_for_create_ticket(@ticket).deliver
             flash[:notice] = "登録が完了しました"
              redirect_to("/registers/#{seller_id}/thankyou")
          end
        end
          
    end
    
    private
    
    def params_ticket
      params.require(:ticket).permit(:seller_id, :stage_id, :kind_id, :payment_id, :count, :buyer_name, :buyer_furigana, :tel, :buyer_mail, :comment1)
    end
    
end
