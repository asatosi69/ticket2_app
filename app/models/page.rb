class Page < ApplicationRecord
    belongs_to :seller
    
    validates :seller_id, presence: true, numericality: { only_integer: true }
    validates :notice, presence: true
end
