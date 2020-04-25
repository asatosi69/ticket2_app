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
    
  def index
      @search_params = ticket_search_params
      @tickets = Ticket.search(@search_params)
  end
    
  def show
      @ticket = Ticket.find_by(id: params[:id])
  end

  def new
      @ticket = Ticket.new
  end

  def create
      @ticket = Ticket.new(params_ticket)
      
      if @ticket.save
          flash[:notice] = "登録が完了しました"
          
          if params[:Renzoku]
              redirect_to("/tickets/new")
          else
              redirect_to("/tickets")
          end
          
      else
          render  'new'
      end
      
  end

  def edit
      @ticket = Ticket.find_by(id: params[:id])
  end

  def update
      @ticket = Ticket.find_by(id: params[:id])
      @ticket.assign_attributes(params_ticket)
      
      if @ticket.save
          flash[:notice] = "編集が完了しました"
          redirect_to("/tickets")
      else
          render  'edit'
      end
  end
  
  def destroy
      @ticket = Ticket.find_by(id: params[:id])
      @ticket.destroy
      
      redirect_to("/tickets")
  end
  
  
  private
  
  def params_ticket
    params.require(:ticket).permit(:seller_id, :stage_id, :kind_id, :payment_id, :count, :buyer_name, :buyer_furigana, :buyer_mail, :comment1, :comment2)
  end
    
  def ticket_search_params
      params.fetch(:search, {}).permit(:seller_id, :stage_id, :kind_id, :payment_id, :buyer_name, :buyer_furigana)
  end
  
end

