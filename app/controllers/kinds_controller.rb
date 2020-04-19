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
        
        # 『チケット種別モデル』のレコード作成時、『色モデル』の『使用済フラグ』を"true"にする
        @color = Color.find(@kind.color_id)
        @color.is_selected = true
        
        @kind.save
        
        @color.save
        
        
        redirect_to("/kinds")
    end

    def edit
        @kind = Kind.find_by(id: params[:id])
    end

    def update
        @kind = Kind.find_by(id: params[:id])
        
        # 『チケット種別モデル』のレコード更新時、『色モデル』の『使用済フラグ』を"false"にする
        # 色が変わる前
        @color = Color.find(@kind.color_id)
        @color.is_selected = false
        @color.save
        
        # 『チケット種別モデル』のレコード更新時、『色モデル』の『使用済フラグ』を"true"にする
        # 色が変わった後
        @kind.assign_attributes(params_kind)
        @color = Color.find(@kind.color_id)
        @color.is_selected = true
        @color.save
        
        @kind.save
        redirect_to("/kinds")
    end
    
    def destroy
        @kind = Kind.find_by(id: params[:id])
        
        # 『チケット種別モデル』のレコードを削除する前に、削除対象のidが『チケットモデル』使用されていないかの確認をする
        @kind.kind_id_already_deleted?
        
        # 『チケット種別モデル』のレコード削除時、『色モデル』の『使用済フラグ』を"false"に戻す
        @color = Color.find(@kind.color_id)
        @color.is_selected = false
        
        @kind.destroy
        
        @color.save
        
        redirect_to("/kinds")
    end
    
    
    private
     def params_kind
      params.require(:kind).permit(:kind, :seats, :price, :color_id)
     end
end
