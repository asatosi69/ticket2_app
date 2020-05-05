class Payment < ApplicationRecord
    has_many :tickets
    
    validates :payment, presence: true
    validates :abbreviation, presence: true
    validates :discount_rate, presence: true, numericality: { only_integer: true }
    
end
