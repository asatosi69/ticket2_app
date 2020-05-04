class RegistersController < ApplicationController
      #『公演』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『公演』モデルにレコードあるかの確認
      before_action :stage_records_empty?, {except: [:destroy]}
      #『チケット種別』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『チケット種別』モデルにレコードあるかの確認
      before_action :kind_records_empty?, {except: [:destroy]}
      #『支払方法』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『支払方法』モデルにレコードあるかの確認
      before_action :payment_records_empty?, {except: [:destroy]}
      #『公演』モデルの各レコードの受付終了時間が現在時間と同じ時間、若しくは過ぎていれば、終了フラグを立てる
      before_action :end_time_past?
      # 予約数が『公演』モデルの各レコードの総席数と同じ、若しくは下回った場合、終了フラグを立てる
      before_action :sold_out?



      
    def new
        @seller = Seller.find(params[:seller_id])
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
        validation_context = current_seller.admin_flag? ? :admin_seller : nil
        
        if @ticket.save
            UserMailer.notice_mail_for_create_ticket(@ticket).deliver
            flash[:notice] = "登録が完了しました"
            
            render :thankyou
            
        end
        
        
        
    end
    
    
    private
    
    def params_ticket
      params.require(:ticket).permit(:seller_id, :stage_id, :kind_id, :payment_id, :count, :buyer_name, :buyer_furigana, :buyer_mail, :comment1)
    end
    
end
