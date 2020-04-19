class Payment < ApplicationRecord
    has_many :tickets
    
    
    def payment_id_already_deleted?
        if Ticket.where(payment_id: self.id).exist?
        flash[:notice] = "『支払方法』を削除する前に、削除したい『支払方法』を使用している『チケット』を削除してください。"
        redirect_to("/tickets")
        end
    end
    
end
