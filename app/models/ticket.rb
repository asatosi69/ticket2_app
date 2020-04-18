class Ticket < ApplicationRecord
    belongs_to :seller
    belongs_to :stage
    belongs_to :kind
    belongs_to :payment
    
end
