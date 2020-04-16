class SellersController < ApplicationController
    
    def index
        if current_seller.admin_flag?
            @sellers = Seller.all
        else
            @sellers = Seller.where(id: current_seller.id)
        end
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
