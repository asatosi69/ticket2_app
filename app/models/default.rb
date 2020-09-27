class Default < ApplicationRecord
    belongs_to :stage
    belongs_to :kind
    belongs_to :payment
end
