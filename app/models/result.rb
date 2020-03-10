class Result < ApplicationRecord
  belongs_to :group
  belongs_to :team
  acts_as_paranoid
end
