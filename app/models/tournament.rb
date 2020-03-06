class Tournament < ApplicationRecord
  has_many :teams
  has_many :groups
  has_many :matches, through: :groups
  after_create :create_team, :create_group

  def create_team
    teams_total.times do |n|
      Team.create(name: "Team #{n + 1}", tournament_id: id, logo: '')
    end
  end

  def create_group
    groups_total.times do |n|
      Group.create(name: "Group #{n + 1}", tournament_id: id)
    end
  end
end
