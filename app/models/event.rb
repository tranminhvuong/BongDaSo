class Event < ApplicationRecord
  belongs_to :user
  has_many :types
  belongs_to :match
  acts_as_paranoid
end
