class Stage < ApplicationRecord
    has_many :tickets
    
    
    def finished
        self.update(end_flag: true)
    end
    
    
end
