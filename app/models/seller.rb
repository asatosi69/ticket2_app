class Seller< ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable
  
  has_many :pages
  has_many :tickets
  
  validates :name, presence: true, uniqueness: true
  validates :rental_tickets, presence: true, numericality: { only_integer: true }
  
  
end
