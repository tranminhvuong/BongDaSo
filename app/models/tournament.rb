class Tournament < ApplicationRecord
  FIRST_GROUP = { '2' => [6, 8, 10, 12, 14], '4' => [16, 20], '6' => [24], '8' => [32] }.freeze
  has_many :teams
  has_many :groups
  has_many :matches, through: :groups
  validates :teams_total, null: false
  after_create :create_team_for_first_round, :create_group_for_first_round, :create_result_for_first_round
  acts_as_paranoid

  def create_team_for_first_round
    teams_total.times do |n|
      teams.build(name: "Team #{n + 1}").save
    end
  end

  def create_group_for_first_round
    if !rule
      group = groups.build(name: 'Season')
      group.save
    else
      first_groups = first_group(teams_total)
      teams_of_first = teams_total / first_groups
      first_groups.times do |n|
        group = groups.build(name: "Group #{n + 1}")
        group.save
      end
    end
  end

  def create_result_for_first_round
    teams_of_group = teams.size / groups.size
    index = 0
    teams.find_each do |team|
      team.results.build(group_id: groups[index].id).save!
      index = index == groups.size - 1 ? 0 : index + 1
    end
  end

  def first_group(num)
    value = FIRST_GROUP.values.detect { |n| n.include?(num) }
    FIRST_GROUP.key(value).to_i
  end
end
