class TicketsController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
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
    # 予約数が『公演』モデルの各レコードの総席数と同じ、若しくは下回った場合、終了フラグを立てる
    after_action :sold_out?, {only: [:create, :update, :destroy]}

    
  def index
      
      @search_params = ticket_search_params
      @tickets = Ticket.search(@search_params).page(params[:page]).per(10)

  end
    
  def show
      @ticket = Ticket.find_by(id: params[:id])
  end

  def new
      @ticket = Ticket.new

  end

  def create
      @ticket = Ticket.new(params_ticket)
      
      validation_context = current_seller.admin_flag? ? :admin_seller : nil
      
      if @ticket.save(context: validation_context)
          flash[:notice] = "登録が完了しました"
          
          if params[:Renzoku]
              UserMailer.notice_mail_for_create_ticket(@ticket).deliver
              redirect_to("/tickets/new")
          else
              UserMailer.notice_mail_for_create_ticket(@ticket).deliver
              redirect_to("/tickets")
          end
              
      else
              render  'new'
      end
      
  end

  def edit
      @ticket = Ticket.find_by(id: params[:id])
      @connections = Connection.all
  end

  def update
      @ticket = Ticket.find_by(id: params[:id])
    
      @ticket.assign_attributes(params_ticket)
      
      validation_context = current_seller.admin_flag? ? :admin_seller : nil
      
      if @ticket.save(context: validation_context)
         UserMailer.notice_mail_for_update_ticket(@ticket).deliver
         flash[:notice] = "編集が完了しました"
         redirect_to("/tickets")
      else
         render  'edit'
      end
      
  end
  
  def destroy
      @ticket = Ticket.find_by(id: params[:id])
      
      @ticket.destroy
      UserMailer.notice_mail_for_destroy_ticket(@ticket).deliver
      redirect_to("/tickets")
  end
  
  
  private
  
  def params_ticket
    params.require(:ticket).permit(:seller_id, :stage_id, :kind_id, :payment_id, :count, :buyer_name, :buyer_furigana, :buyer_mail, :visited_flag, :comment1, :comment2, :cipher)
  end
    
  def ticket_search_params
    params.fetch(:search, {}).permit(:seller_id, :stage_id, :kind_id, :payment_id, :buyer_name, :buyer_furigana, :chk1, :chk2)
  end
  
end

