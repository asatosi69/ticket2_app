class Kind < ApplicationRecord
    belongs_to :color
    has_many :tickets
    has_many :defaults
    has_many :connections, dependent: :destroy
    has_many :stages, through: :connections, dependent: :destroy
    has_many :connection2s, dependent: :destroy
    has_many :payments, through: :connection2s, dependent: :destroy
    
    validates :kind, presence: true
    validates :seats, presence: true, numericality: { only_integer: true }
    validates :price, presence: true, numericality: { only_integer: true }
    validates :color_id, presence: true, uniqueness: true, numericality: { only_integer: true }
    validates :default, uniqueness: true
    
end
