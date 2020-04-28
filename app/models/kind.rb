class Kind < ApplicationRecord
    belongs_to :color
    has_many :tickets
    has_many :connections
    has_many :stages, through: :connections
    
    validates :kind, presence: true, uniqueness: true
    validates :seats, presence: true, numericality: { only_integer: true }
    validates :price, presence: true, numericality: { only_integer: true }
    validates :color_id, presence: true, uniqueness: true, numericality: { only_integer: true }
    
end
