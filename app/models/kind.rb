class Kind < ApplicationRecord
    belongs_to :color
    has_many :tickets
    
    
    def self.kind_id_already_deleted?(id)
        if Ticket.where(kind_id: id).exist?
        flash[:notice] = "『チケット種別』を削除する前に、削除したい『チケット種別』を使用している『チケット』を削除してください。"
        redirect_to("/tickets")
        end
    end
    
end
