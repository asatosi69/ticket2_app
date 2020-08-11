class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :master_record?
  before_action :subdomain
  before_action :establish_subdomain
  
  
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end
    
    def establish_subdomain
        ActiveRecord::Base.establish_connection :"ticket2_app_#{subdomain}_development".to_s.to_sym
    end
    
    def subdomain
        request.subdomain.to_s.to_sym
    end
    
    def after_sign_in_path_for(resource)
      pages_path # ログイン後に遷移するpathを設定
    end
    
    # 『管理取扱者』と『一般取扱者』では操作できる内容が異なる
    def admin_seller?
        unless current_seller.admin_flag?
            flash[:notice] = "管理取扱者以外の方は操作できません。"
            redirect_to("/pages")
        end
    end

#『公演』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『公演』モデルにレコードあるかの確認
    def stage_records_empty?
        @stages = Stage.all

        if @stages.empty?
           flash[:notice] = "予約情報の『確認/登録/編集』には、先に『公演』の登録が必須です。"
           redirect_to("/stages")
        end
    end

#『チケット種別』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『チケット種別』モデルにレコードあるかの確認
    def kind_records_empty?
        @kinds = Kind.all

        if @kinds.empty?
           flash[:notice] = "予約情報を『確認/登録/編集』には、先に『チケット種別』の登録が必須です。"
           redirect_to("/kinds")
        end
    end

#『支払方法』モデルにレコードが無い状態で『チケット』関連処理が実行されるのを避けるため、『支払方法』モデルにレコードあるかの確認
    def payment_records_empty?
        @payments = Payment.all

        if @payments.empty?
            flash[:notice] = "予約情報を『確認/登録/編集』には、先に『支払方法』の登録が必須です。"
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

# 予約数が『公演』モデルの各レコードの総席数と同じ、若しくは下回った場合、終了フラグを立てる
# 『公演』モデルの残席数をセットする
    def sold_out?
        @stages = Stage.all.order(stage_time: "ASC")
        @kinds = Kind.all.order(kind: "ASC")
        
        @stages.each do |stage|
            sum = 0
            @kinds.each do |kind|
              @seats_count = Ticket.tickets_in_the_stage(stage.id, kind.id)
              sum += @seats_count * kind.seats
            end
            
            # 公演』モデルの残席数をセットする
            Stage.remaining_tickets(stage.id, sum)
            
            if sum >= stage.total_seats
                # 終了フラグを立てる
                stage.finished
            end
        end
    end
    
    # チケットレコードを作成するの必要なマスタ(『公演』/『チケット種別』/『支払方法』)のレコードが存在するのか確認する(register_controller用以外)
    def master_record?
        
        @master_stage = Stage.all
        @master_kind = Kind.all
        @master_payment = Payment.all
        
    end
    
    # チケットレコードを作成するの必要なマスタ(『公演』/『チケット種別』/『支払方法』)のレコードが存在するのか確認する(register_controller用)
    def master_record2?
        
        @master_stage = Stage.all
        @master_kind = Kind.all
        @master_payment = Payment.all
        
        if @master_stage.empty? || @master_kind.empty? || @master_payment.empty?
            redirect_to("http://www.google.co.jp")
        end
        
    end
    
  def render_404
      render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end
    
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
    
end
