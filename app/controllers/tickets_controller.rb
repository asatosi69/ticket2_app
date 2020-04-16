class TicketsController < ApplicationController
    #『公演』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『公演』モデルにレコードあるかの確認
    before_action :stage_records_empty?, {except: [:destroy]}
    #『チケット種別』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『チケット種別』モデルにレコードあるかの確認
    before_action :kind_records_empty?, {except: [:destroy]}
    #『支払方法』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『支払方法』モデルにレコードあるかの確認
    before_action :payment_records_empty?, {except: [:destroy]}
    #『公演』モデルの各レコードの受付終了時間が現在時間と同じ時間、若しくは過ぎていれば、終了フラグを立てる
    before_action :end_time_past?
    
  def index
      if current_seller.admin_flag?
          @tickets = Ticket.all
      else
          @tickets = Ticket.where(seller_id: current_seller.id)
      end
  end
  
  def show
      @ticket = Ticket.find_by(id: params[:id])
  end

  def new
      @ticket = Ticket.new
  end

  def create
      @ticket = Ticket.new(params_ticket)
      
      @ticket.save
      redirect_to("/tickets")
  end

  def edit
      @ticket = Ticket.find_by(id: params[:id])
  end

  def update
      @ticket = Ticket.find_by(id: params[:id])
      @ticket.assign_attributes(params_ticket)
      
      
      @ticket.save
      redirect_to("/tickets")
  end
  
  def destroy
      @ticket = Ticket.find_by(id: params[:id])
      @ticket.destroy
      
      redirect_to("/tickets")
  end
  
  #『公演』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『公演』モデルにレコードあるかの確認
  def stage_records_empty?
      @stages = Stage.all
      
      if @stages.empty?
          flash[:notice] = "予約情報の『確認/登録/編集』には『公演』の登録が必須です。"
          redirect_to("/stages")
      end
  end
  
  #『チケット種別』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『チケット種別』モデルにレコードあるかの確認
  def kind_records_empty?
      @kinds = Kind.all
      
      if @kinds.empty?
          flash[:notice] = "予約情報を『確認/登録/編集』には『チケット種別』の登録が必須です。"
          redirect_to("/kinds")
      end
  end
  
  #『支払方法』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『支払方法』モデルにレコードあるかの確認
  def payment_records_empty?
      @payments = Payment.all
      
      if @payments.empty?
          flash[:notice] = "予約情報を『確認/登録/編集』には『支払方法』の登録が必須です。"
          redirect_to("/payments")
      end
  end
  
  #『公演』モデルの各レコードの受付終了時間が現在時間と同じ時間、若しくは過ぎていれば、終了フラグを立てる
  def end_time_past?
      @stages = Stage.where("end_time <= ?", Time.now.to_datetime)
      
      @stages.each do |stage|
          stage.finished
      end
  end
  
  private
   def params_ticket
    params.require(:ticket).permit(:seller_id, :stage_id, :kind_id, :payment_id, :count, :buyer_name, :buyer_furigana, :buyer_mail, :comment1, :comment2)
   end
  
end
