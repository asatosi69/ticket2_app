class Payment < ApplicationRecord
    has_many :tickets
    has_many :connection3s, dependent: :destroy
    has_many :stages, through: :connection3s, dependent: :destroy
    has_many :connection2s, dependent: :destroy
    has_many :kinds, through: :connection2s, dependent: :destroy
    
    validates :payment, presence: true
    validates :abbreviation, presence: true, length: {maximum: 3}
    validates :discount_rate, presence: true, numericality: { only_integer: true }
    
end
