class Connection < ApplicationRecord
  belongs_to :stage
  belongs_to :kind
  
  validates :stage_id, presence: true
  validates :kind_id, presence: true
end
