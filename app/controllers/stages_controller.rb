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
        
        # 『公演』のレコードを削除する前に、削除対象のidが『チケットモデル』使用されていないかの確認をする
        if Ticket.where(stage_id: @stage.id).exists?
          flash[:alert] = "『公演』を削除する前に、削除したい『公演』を使用している『チケット』を削除してください。"
        else
          @stage.destroy
        end
       
        
        redirect_to("/stages")
    end
    
    #『公演』モデルの各レコードの受付終了時間が現在時間と同じ時間、若しくは過ぎていれば、終了フラグを立てる
    def end_time_past?
        @stages = Stage.where("end_time <= ?", Time.now.to_datetime)
        
        @stages.each do |stage|
            stage.finished
        end
    end
    
    private
     def params_stage
      params.require(:stage).permit(:stage, :total_seats, :end_time, :end_flag)
     end
end
