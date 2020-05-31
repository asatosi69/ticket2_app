class DownloadsController < ApplicationController
  # ログインしているユーザーのみ操作できるようにする
  before_action :authenticate_seller!
  # 『管理者』として、ログインしないと処理は実行できない
  before_action :admin_seller?
 
  def index
     @tickets = Ticket.all
  end
  
  def download
     @tickets = Ticket.all
     
     respond_to do |format|
       format.csv do
         send_data render_to_string, filename: "hoge.csv", type: :csv
       end
     end
  end
    
end
