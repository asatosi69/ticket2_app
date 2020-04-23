class StagesController < ApplicationController
    # 『管理取扱者』と『一般取扱者』では操作できる内容が異なる。『一般取扱者』は操作不可。
    before_action :admin_seller?
    
    def index
        @stages = Stage.all
    end

    def new
        @stage = Stage.new
    end

    def create
        @stage = Stage.new(params_stage)

        @stage.save
        redirect_to("/stages")
    end

    def edit
        @stage = Stage.find_by(id: params[:id])
    end

    def update
        @stage = Stage.find_by(id: params[:id])
        @stage.assign_attributes(params_stage)
        
        @stage.save
        redirect_to("/stages")
    end
    
    def destroy
        @stage = Stage.find_by(id: params[:id])
        
        # 『チケット種別モデル』のレコードを削除する前に、削除対象のidが『チケットモデル』使用されていないかの確認をする
        Stage.stage_id_already_deleted?(@stage.id)
        #or
        #stage_id_already_deleted?(@stage.id)
        
        @stage.destroy
        
        redirect_to("/stages")
    end
    
    private
     def params_stage
      params.require(:stage).permit(:stage, :total_seats, :end_time, :end_flag)
     end
end
