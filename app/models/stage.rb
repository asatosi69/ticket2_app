class Stage < ApplicationRecord
    has_many :tickets
    has_many :connections
    has_many :kinds, through: :connections
    
    validates :stage, presence: true, uniqueness: true
    validates :total_seats, presence: true,  numericality: { only_integer: true }
    validates :end_time, presence: true
    
    
    def finished
        self.update(end_flag: true)
    end
    
    
end
