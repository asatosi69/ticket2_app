class Payment < ApplicationRecord
    has_many :tickets
    
    validates :payment, presence: true
    validates :abbreviation, presence: true, length: {maximum: 3}
    validates :discount_rate, presence: true, numericality: { only_integer: true }
    
end
