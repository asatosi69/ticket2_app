class KindsController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    # 『管理取扱者』と『一般取扱者』では操作できる内容が異なる。『一般取扱者』は操作不可。
    before_action :admin_seller?
    
    
    def index
        @kinds = Kind.all
    end

    def new
        @kind = Kind.new
        @kind.connections.build
    end

    def create
        @kind = Kind.new(params_kind)
        
        # 『チケット種別モデル』のレコード作成時、『色モデル』の『使用済フラグ』を"true"にする
        Color.selected_color(@kind.color_id)
        
        # モデル『Connection』に新しい『@kind』の情報を登録するための処理
        @stages = Stage.all
        @stages.each do |stage|
            @kind.stages << stage
        end
        
        if @kind.save
            flash[:notice] = "登録が完了しました"
            redirect_to("/kinds")
        else
            render  'new'
        end
        

    end

    def edit
        @kind = Kind.find_by(id: params[:id])
    end

    def update
        @kind = Kind.find_by(id: params[:id])
        
        
        # 元の色
        # 『チケット種別モデル』のレコード更新時、『色モデル』の『使用済フラグ』を"false"にする
        Color.unselected_color(@kind.color_id)
        
        
        @kind.assign_attributes(params_kind)
       
        # 選択された色
        # 『チケット種別モデル』のレコード更新時、『色モデル』の『使用済フラグ』を"true"にする
        Color.selected_color(@kind.color_id)
        
        if @kind.save
            flash[:notice] = "編集が完了しました"
            redirect_to("/kinds")
        else
            render  'edit'
        end
        
    end
    
    def destroy
        @kind = Kind.find_by(id: params[:id])
        
        # 『チケット種別モデル』のレコード削除時、『色モデル』の『使用済フラグ』を"false"に戻す
        Color.unselected_color(@kind.color_id)
        
        # 『チケット種別』のレコードを削除する前に、削除対象のidが『チケットモデル』使用されていないかの確認をする
        if Ticket.where(kind_id: @kind.id).exists?
            flash[:alert] = "『チケット種別』を削除する前に、削除したい『チケット種別』を使用している『チケット』を削除してください。"
        else
            @kind.destroy
        end
        
        
        redirect_to("/kinds")
    end
    
    
    private
     def params_kind
      params.require(:kind).permit(:kind, :seats, :price, :color_id, { :stage_ids=> [] })
     end
end
