class StagesController < ApplicationController
    # ログインしているユーザーのみ操作できるようにする
    before_action :authenticate_seller!
    # 『管理取扱者』と『一般取扱者』では操作できる内容が異なる。『一般取扱者』は操作不可。
    before_action :admin_seller?
    #『公演』モデルの各レコードの受付終了時間が現在時間と同じ時間、若しくは過ぎていれば、終了フラグを立てる
    before_action :end_time_past?
    
    def index
        @stages = Stage.all
    end

    def new
        @stage = Stage.new
        @stage.connections.build
    end

    def create
        
        @stage = Stage.new(params_stage)
        
        # モデル『Connection』に新しい『@stage』の情報を登録するための処理
        @kinds = Kind.all
        @kinds.each do |kind|
            @stage.kinds << kind
        end
        

        if @stage.save
            flash[:notice] = "登録が完了しました"
            redirect_to("/stages")
        else
            render  'new'
        end
    end

    def edit
        @stage = Stage.find_by(id: params[:id])
    end

    def update
        @stage = Stage.find_by(id: params[:id])
        @stage.assign_attributes(params_stage)
        
        if @stage.save
            flash[:notice] = "編集が完了しました"
            redirect_to("/stages")
        else
            render  'edit'
        end
        
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
      params.require(:stage).permit(:stage, :total_seats, :end_time, :end_flag, { :kind_ids=> [] })
     end
end
