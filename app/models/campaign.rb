# Campaign Model
class Campaign < ApplicationRecord
  has_many :choices

  validates_presence_of :name
end
