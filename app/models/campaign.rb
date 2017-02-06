# Campaign Model
class Campaign < ApplicationRecord
  has_many :choices
  has_many :votes, through: :choices

  validates_presence_of :name
end
