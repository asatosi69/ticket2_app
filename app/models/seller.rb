class Seller< ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable
  
  has_many :pages
  has_many :tickets
  
  
  def seller_id_already_deleted?
      if Ticket.where(seller_id: self.id).exist?
      flash[:notice] = "『取扱者』を削除する前に、削除したい『取扱者』を使用している『チケット』を削除してください。"
      redirect_to("/tickets")
      end
  end
  
end
