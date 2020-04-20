class Color < ApplicationRecord
    has_one :kind

    def self.selected_color
        Color.find(@kind.color_id).update(is_selected: true)
    end

end
