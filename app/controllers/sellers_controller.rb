class SellersController < ApplicationController
    
    def index
        @sellers = Seller.all
    end
    
    def create
    end
    
    def new
    end
    
    def edit
    end
    
    def show
    end
    
    def update
        @seller = Seller.find_by(id: params[:id])
        @seller.admin_flag = !@seller.admin_flag
        
        @seller.save
        redirect_to("/sellers")
    end
    
    def destroy
        @seller = Seller.find_by(id: params[:id])
        @seller.destroy
        
        redirect_to("/sellers")
    end
    
end
