class Event < ApplicationRecord
  belongs_to :player
  belongs_to :result
  acts_as_paranoid
end
