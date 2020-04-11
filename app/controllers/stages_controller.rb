class StagesController < ApplicationController
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
        @stage.destroy
        
        redirect_to("/stages")
    end
    
    private
     def params_stage
      params.require(:stage).permit(:stage, :total_seats, :end_time, :end_flag)
     end
end
