class Stage < ApplicationRecord
    has_many :tickets
    
    
    def finished
        self.update(end_flag: true)
    end
    
    
    #def stage_id_already_deleted?(id)
    #    if Ticket.where(stage_id: id).exist?
    #      flash[:notice] = "『公演』を削除する前に、削除したい『公演』を使用している『チケット』を削除してください。"
    #    redirect_to("/tickets")
    #    end
    #end
    
    def self.stage_id_already_deleted?(id)
        if Ticket.where(stage_id: id).exist?
          flash[:notice] = "『公演』を削除する前に、削除したい『公演』を使用している『チケット』を削除してください。"
        redirect_to("/tickets")
        end
    end
    
    
end
