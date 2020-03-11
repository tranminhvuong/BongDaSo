class Team < ApplicationRecord
  has_many :players
  has_many :results
  belongs_to :tournament
  has_many :groups, through: :results
  acts_as_paranoid
  after_create :create_players

  def create_players
    11.times do |n|
      players.build(name: Faker::Name.name, address: "Danang", date_of_birth: Faker::Date.in_date_period(year: 1996), position_id: n + 1).save
    end
  end
end
