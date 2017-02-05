# Vote Model
class Vote < ApplicationRecord
  belongs_to :choice

  validates_presence_of :time
  validates_inclusion_of :valid_vote, in: [true, false]
end
