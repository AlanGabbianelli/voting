# Choice Model
class Choice < ApplicationRecord
  belongs_to :campaign
  has_many :votes

  validates_presence_of :name
  validates_uniqueness_of :name, scope: :campaign_id, case_sensitive: false
end
