class Kind < ApplicationRecord
    belongs_to :color
    has_many :tickets
    
    
end
