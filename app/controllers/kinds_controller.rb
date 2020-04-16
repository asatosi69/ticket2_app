class KindsController < ApplicationController
    # 『管理取扱者』と『一般取扱者』では操作できる内容が異なる。『一般取扱者』は操作不可。
    before_action :admin_seller?
    
    def index
        @kinds = Kind.all
    end

    def new
        @kind = Kind.new
    end

    def create
        @kind = Kind.new(params_kind)
        @color = Color.find(@kind.color_id)
        binding.pry
        @color.is_selected = true
        @kind.save
        binding.pry
        @color.save
        
        
        redirect_to("/kinds")
    end

    def edit
        @kind = Kind.find_by(id: params[:id])
    end

    def update
        @kind = Kind.find_by(id: params[:id])
        @kind.assign_attributes(params_kind)
        @color = Color.find(@kind.color_id)
        binding.pry
        @color.is_selected = true
        binding.pry
        @color.save
        
        @kind.save
        redirect_to("/kinds")
    end
    
    def destroy
        @kind = Kind.find_by(id: params[:id])
        @color = Color.find(@kind.color_id)
        binding.pry
        @color.is_selected = false
        @kind.destroy
        binding.pry
        @color.save
        
        redirect_to("/kinds")
    end
    
    private
     def params_kind
      params.require(:kind).permit(:kind, :seats, :price, :color_id)
     end
end
