class PagesController < ApplicationController
  def index
      @pages = Page.all.order(updated_at: "DESC")
  end

  def new
      @page = Page.new
  end

  def create
      @page = Page.new(params_page)

      @page.save
      redirect_to("/pages")
  end

  def edit
      @page = Page.find_by(id: params[:id])
  end

  def update
      @page = Page.find_by(id: params[:id])
      @page.assign_attributes(params_page)
      
      @page.save
      redirect_to("/pages")
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
