class Match < ApplicationRecord
  has_many :events
  belongs_to :place
  belongs_to :group
  acts_as_paranoid
end
