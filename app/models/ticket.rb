class Ticket < ApplicationRecord
  belongs_to :seller, optional: true
end
