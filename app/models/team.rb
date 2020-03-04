class Team < ApplicationRecord
  has_many :players
  has_many :results
  belongs_to :tournament
  belongs_to :user, foreign_key: 'manager_id'
end
