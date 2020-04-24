class PagesController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    
  def index
      @pages = Page.all.order(updated_at: "DESC")
  end

  def new
      @page = Page.new
  end

  def create
      @page = Page.new(params_page)

      if @page.save
          flash[:notice] = "登録が完了しました"
          redirect_to("/pages")
      else
          render  'new'
      end
      
  end

  def edit
      @page = Page.find_by(id: params[:id])
  end

  def update
      @page = Page.find_by(id: params[:id])
      @page.assign_attributes(params_page)
      
      if @page.save
          flash[:notice] = "編集が完了しました"
          redirect_to("/pages")
      else
          render  'edit'
      end
  end
  
  def destroy
      @page = Page.find_by(id: params[:id])
      @page.destroy
      
      redirect_to("/pages")
  end
  
  private
   def params_page
    params.require(:page).permit(:notice, :updated_at, :seller_id)
   end
end
