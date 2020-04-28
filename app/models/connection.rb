class Connection < ApplicationRecord
  belongs_to :stage
  belongs_to :kind
end
