class TicketsController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    #『公演』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『公演』モデルにレコードあるかの確認
    before_action :stage_records_empty?
    #『チケット種別』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『チケット種別』モデルにレコードあるかの確認
    before_action :kind_records_empty?
    #『支払方法』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『支払方法』モデルにレコードあるかの確認
    before_action :payment_records_empty?
    #『公演』モデルの各レコードの受付終了時間が現在時間と同じ時間、若しくは過ぎていれば、終了フラグを立てる
    before_action :end_time_past?
    # 予約数が『公演』モデルの各レコードの総席数と同じ、若しくは上回った場合、終了フラグを立てる
    before_action :sold_out?
    # 予約数が『公演』モデルの各レコードの総席数と同じ、若しくは上回った場合、終了フラグを立てる
    after_action :sold_out?, {only: [:create, :update, :destroy]}

    
  def index
      
      @search_params = ticket_search_params
      
      if current_seller.admin_flag?
          
        @tickets = Ticket.search(@search_params).order(created_at: "DESC").page(params[:page]).per(20)
        
      elsif @search_params.empty?
         
        @tickets = Ticket.where(seller_id: current_seller.id).order(created_at: "DESC").page(params[:page]).per(20)
         
      else
        
        @tickets = Ticket.search(@search_params).order(created_at: "DESC").page(params[:page]).per(20)
          
      end
      
      render 'tickets/index', layout: "application"
      
  end
    
  def show
      @ticket = Ticket.find_by(id: params[:id])
      
      # 『取扱者』の場合は自分以外の予約の操作はできない
      unless current_seller.admin_flag?
          # 自分以外の予約
          if current_seller.id != @ticket.seller_id
            flash[:notice] = "他の取扱者の予約は操作できません"
            redirect_to("/tickets")
          end
      end
  end

  def new
      if Ticket.where(seller_id: current_seller.id).count == 0
          @ticket = Ticket.new
      else
          @tickets = Ticket.order(updated_at: :DESC).where(seller_id: current_seller.id).limit(1)
          @tickets.each do |ticket|
            @stage = Stage.find_by(id: ticket.stage_id)
            if @stage.end_flag == true and current_seller.admin_flag == false
               @ticket = Ticket.new(:published => ticket.published, :seller_id => ticket.seller_id,
                                    :kind_id => ticket.kind_id, :payment_id => ticket.payment_id,
                                    :count => ticket.count)
            else
               @ticket = Ticket.new(:published => ticket.published, :seller_id => ticket.seller_id,
                                    :stage_id => ticket.stage_id, :kind_id => ticket.kind_id,
                                    :payment_id => ticket.payment_id, :count => ticket.count)
            end
            
          end
      end
      
  end

  def create
      @ticket = Ticket.new(params_ticket)
      @ticket.reviser = current_seller.name
      
      subdomain = request.subdomain.to_s.to_sym
      
      validation_context = current_seller.admin_flag? ? :admin_seller : nil
      
      check = 0
      
      unless @ticket.payment.discount_keyword.empty?
      
          keywords = @ticket.payment.discount_keyword.split(",")
   
          for keyword in keywords do
               check = 1  if @ticket.comment1.include?(keyword)
          end
          
          if check == 1
      
              if @ticket.save(context: validation_context)
                  flash[:notice] = "登録が完了しました"
          
                  if params[:Renzoku]
                      UserMailer.with(subdomain: subdomain).notice_mail_for_create_ticket(@ticket).deliver
                      redirect_to("/tickets/new")
                  else
                      UserMailer.with(subdomain: subdomain).notice_mail_for_create_ticket(@ticket).deliver
                      redirect_to("/tickets")
                  end
                  
              else
                  render 'new'
              end
              
          else
            flash[:notice] = "割引キーワードが正しくありません。"
            redirect_to("/tickets/new")
          end
            
      else
      
          if @ticket.save(context: validation_context)
                  flash[:notice] = "登録が完了しました"
                  if params[:Renzoku]
                      UserMailer.with(subdomain: subdomain).notice_mail_for_create_ticket(@ticket).deliver
                      redirect_to("/tickets/new")
                  else
                      UserMailer.with(subdomain: subdomain).notice_mail_for_create_ticket(@ticket).deliver
                      redirect_to("/tickets")
                  end
                  
              else
                  render 'new'
              end
      end
      
  end
      
  def edit
      
      @ticket = Ticket.find_by(id: params[:id])
      
      subdomain = request.subdomain.to_s.to_sym
      
      # 『取扱者』の場合は自分以外の予約の操作はできない
      unless current_seller.admin_flag?
          # 自分以外の予約
          if current_seller.id != @ticket.seller_id
            flash[:notice] = "他の取扱者の予約は操作できません"
            redirect_to("/tickets")
          end
      end
      
      @connections = Connection.all
  end
  

  def update
      @ticket = Ticket.find_by(id: params[:id])
      @ticket.reviser = current_seller.name
      subdomain = request.subdomain.to_s.to_sym
     
      @delete = Delete.new
      @delete = Ticket.find_by(id: params[:id])
      
      @delete = Delete.new(:published => @ticket.published,
                           :seller_id => @ticket.seller_id,
                           :kind_id => @ticket.kind_id,
                           :stage_id => @ticket.kind_id,
                           :payment_id => @ticket.payment_id,
                           :count => @ticket.count,
                           :buyer_name => @ticket.buyer_name,
                           :buyer_furigana => @ticket.buyer_furigana,
                           :buyer_mail => @ticket.buyer_mail,
                           :comment1 => @ticket.comment1,
                           :comment2 => @ticket.comment2,
                           :enquete_flag => @ticket.enquete_flag,
                           :visited_flag => @ticket.visited_flag,
                           :reviser => @ticket.reviser,
                           :tel => @ticket.tel)
                        
      
      if params[:Sakujyo]
         
         # 『取扱者』の場合は自分以外の予約の操作はできない
         unless current_seller.admin_flag?
             # 自分以外の予約
             if current_seller.id != @ticket.seller_id
               flash[:notice] = "他の取扱者の予約は操作できません"
               redirect_to("/tickets")
             end
         end

         @delete.save
         @ticket.destroy
         UserMailer.with(subdomain: subdomain).notice_mail_for_destroy_ticket(@ticket).deliver
         redirect_to("/tickets")

      else
      
          # 『取扱者』の場合は自分以外の予約の操作はできない
          unless current_seller.admin_flag?
              # 自分以外の予約
              if current_seller.id != @ticket.seller_id
                flash[:notice] = "他の取扱者の予約は操作できません"
                redirect_to("/tickets")
              end
          end
        
          @ticket.assign_attributes(params_ticket)
          
          validation_context = current_seller.admin_flag? ? :admin_seller : nil
          
          check = 0
             
          unless @ticket.payment.discount_keyword.empty?
             
              keywords = @ticket.payment.discount_keyword.split(",")
          
              for keyword in keywords do
                   check = 1  if @ticket.comment1.include?(keyword)
              end
                 
              if check == 1
          
                  if @ticket.save(context: validation_context)
                        UserMailer.with(subdomain: subdomain).notice_mail_for_update_ticket(@ticket).deliver
                        flash[:notice] = "編集が完了しました"
                        redirect_to("/tickets")
                  else
                        render 'edit'
                  end
              else
                  flash[:notice] = "割引キーワードが正しくありません。"
                  render 'edit'
              end
              
          else
              if @ticket.save(context: validation_context)
                 UserMailer.with(subdomain: subdomain).notice_mail_for_create_ticket(@ticket).deliver
                 flash[:notice] = "編集が完了しました"
                 redirect_to("/tickets")
              else
                render 'edit'
              end
          end
      end
  end
  
  def destroy
      @ticket = Ticket.find_by(id: params[:id])
      subdomain = request.subdomain.to_s.to_sym
      
      # 『取扱者』の場合は自分以外の予約の操作はできない
      unless current_seller.admin_flag?
          # 自分以外の予約
          if current_seller.id != @ticket.seller_id
            flash[:notice] = "他の取扱者の予約は操作できません"
            redirect_to("/tickets")
          end
      end
      

      @ticket.destroy
      UserMailer.with(subdomain: subdomain).notice_mail_for_destroy_ticket(@ticket).deliver
      redirect_to("/tickets")
  end
  
  def download
     @tickets = Ticket.all
     @subdomain = request.subdomain.to_s.to_sym
     
     respond_to do |format|
       format.csv do
         send_data render_to_string, filename: "tickets.csv", type: :csv
       end
     end
  end
  
 
  def correct_user?
      
      if not current_seller.admin_flag
          
          if @current_seller.id != params[:id].to_i
            flash[:notice] = "他の取扱者の予約は操作できません"
            redirect_to("/tickets")
          end
    
      end
      
  end
  
  private
  
  def params_ticket
    params.require(:ticket).permit(:seller_id, :stage_id, :kind_id, :payment_id, :count, :buyer_name, :buyer_furigana, :tel, :buyer_mail, :visited_flag, :comment1, :comment2, :enquete_flag, :published)
  end
    
  def ticket_search_params
    params.fetch(:search, {}).permit(:seller_id, :stage_id, :kind_id, :payment_id, :buyer_name, :buyer_furigana, :chk1, :chk2, :chk3, :enquete_flag)
  end
  
end
