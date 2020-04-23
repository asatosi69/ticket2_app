class Color < ApplicationRecord
    has_one :kind

    def self.selected_color(color_id)
        self.find(color_id).update(is_selected: true)
    end
    
    def self.unselected_color(color_id)
        self.find(color_id).update(is_selected: false)
    end

end
