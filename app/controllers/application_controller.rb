class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
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
    
end
