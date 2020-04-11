class KindsController < ApplicationController
    def index
        @kinds = Kind.all
    end

    def new
        @kind = Kind.new
    end

    def create
        @kind = Kind.new(params_kind)

        @kind.save
        redirect_to("/kinds")
    end

    def edit
        @kind = Kind.find_by(id: params[:id])
    end

    def update
        @kind = Kind.find_by(id: params[:id])
        @kind.assign_attributes(params_kind)
        
        @kind.save
        redirect_to("/kinds")
    end
    
    def destroy
        @kind = Kind.find_by(id: params[:id])
        @kind.destroy
        
        redirect_to("/kinds")
    end
    
    private
     def params_kind
      params.require(:kind).permit(:kind, :seats, :price, :color_id)
     end
end
