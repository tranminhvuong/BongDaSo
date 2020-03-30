class Admin::TournamentsController < ApplicationController
  layout 'admin/application'
  GROUP = '1'.freeze
  ROUND_ROBIN = '2'.freeze
  GROUPS_AND_GOON = { '4' => [2, 2], '8' => [2, 4], '16' => [4, 8], '32' => [4, 16] }.freeze
  GROUP_TYPE = { name: 'group', round_type: 'group_stage' }.freeze
  before_action :logged_in_user, :admin_user, only: %i[index show new create edit update destroy]

  def index
    @tournaments = Tournament.includes(:teams).paginate(page: params[:page], per_page: 5)
  end

  def show
    @tour = Tournament.includes(:teams).find_by(id: params[:id])
    if @tour
      @teams = @tour.teams
      @rounds = @tour.rounds.includes(:ranks, :matches).to_a
    else
      return render partial: 'layouts/admin/errors'

    end
  end

  def new
    @tour = Tournament.new
  end

  def create
    create_tour!
    create_teams!
    create_player!
    create_rounds!
    redirect_to admin_tournament_path(@tour)
  end

  def edit
    @tour = Tournament.find_by(id: params[:id])
    if @tour.nil?
      return render partial: 'layouts/admin/not_found'
    
    end
  end

  def update
    @tour = Tournament.find_by(id: params[:id])
    if @tour&.update_attributes(update_tour_params)
      render @tour
    else
      render :edit
    end
  end

  def destroy
    tour = Tournament.find_by(id: params[:id])
    if tour&.destroy
      redirect_to admin_tournaments_path
    end
  end

  private

  def create_tour_params
    params.require(:tournament).permit(:name, :time_start, :time_end, :description, :formula)
  end

  def update_tour_params
    params.require(:tournament).permit(:name, :time_start, :time_end, :description)
  end

  def create_tour!
    params[:tournament][:time_start] = Time.zone.parse(params[:tournament][:time_start])
    params[:tournament][:time_end] = Time.zone.parse(params[:tournament][:time_end])
    @tour = Tournament.create!(create_tour_params)
  end

  def create_teams!
    @teams = (1..params[:num_of_teams].to_i).map do |i|
      @tour.teams.build(name: "Team #{i}").save!
    end
  end

  def create_player!
    teams = @tour.teams.to_a
    teams.each do |team|
      11.times { |n| team.players.build(name: Faker::Name.name, position: 'goal keeper', number: 0).save }
    end
  end

  def true?(obj)
    obj.downcase == 'true'
  end

  def create_rounds!
    total_teams = params[:num_of_teams].to_i
    is_back_turn = true?(params[:is_return])
    if @tour.formula == GROUP
      GROUPS_AND_GOON[params[:num_of_teams]][0].times do |n|
        @tour.rounds.build(name: "Group #{(65 + n).chr}", is_return: is_back_turn, num_of_teams: total_teams)
      end
    else
      round_detail = RoundDetail.new(name: 'Round Robin', num_of_teams: total_teams,
                                     round_type: 'cycle')
      round_detail.save!
      @round = @tour.rounds.build(name: 'Round Robin', is_return: is_back_turn,
                                     round_detail_id: round_detail.id)
      @round.save
      @tour.teams.to_a.each { |team| @round.ranks.build(team_id: team.id).save! }
      @teams = @tour.teams.to_a
      @matches = @round.matches.to_a
      if is_back_turn
        create_match!
        s = @teams.size
        temp = @teams.slice!(s - 1, 1)[0]
        @teams.insert(1, temp)
        @teams.reverse!
        create_match!(s * (s - 1) / 2 + 1) 
      else
        create_match! 
      end
    end
  end

  def create_match!(j = 1)
    s = @teams.size
    (s - 1).times do
      (s / 2).times do |n|
        match = @round.matches.build(turn: j, place: Faker::Address.city,
          time: params[:tournament][:time_start] + (j + 1) *60 * 60 * 24)
        match.save!
        @teams[n].results.build(match_id: match.id).save!
        @teams[s - 1 - n].results.build(match_id: match.id).save!
        j += 1
      end
      temp = @teams.slice!(s - 1, 1)[0]
      @teams.insert(1, temp)
    end
  end
end
