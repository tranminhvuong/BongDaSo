class Admin::TournamentsController < ApplicationController
  layout 'admin/application'
  GROUP = '1'.freeze
  ROUND_ROBIN = '2'.freeze
  GROUPS_AND_GOON = {'4' => [2, 2], '8' => [2, 4], '16' => [4, 8], '32' => [4, 16]}.freeze
  GROUP_TYPE = { name: 'group', round_type: 'group_stage' }.freeze

  def index
    @tours = Tournament.all
  end

  def show
    @tour = Tournament.includes(:teams).find_by(id: params[:id])
    @teams = @tour.teams 
    @rounds = @tour.rounds.includes(:ranks, :matches).to_a
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
    else
      redirect_to admin_tournament_path(tour)
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
        # Tuỳ vào số team để tạo tiếp các vòng sau
        # Nếu có 32 teams chia cho 4 bảng thì đồng nghĩa còn 16 đội đi vào trong
        # Tạo Round_of_16 cho 16 đội # options tuỳ vào số đội
        # Tạo Tứ kết cho 8 đội # options tuỳ vào số đội
        # Tạo Bán kết cho 4 đội # bắt buộc
        # Tạo Chung kết cho 2 đội # bắt buộc
        # -> Thấy nó chia dần cho 2 không nên có thể dùng đệ quy ở đây hoặc if số đội else tuỳ chú
    else @tour.formula == ROUND_ROBIN
      round_detail = RoundDetail.new(name: "Round Robin", num_of_teams: total_teams, round_type: 'cycle')
      round_detail.save!
      @round = @tour.rounds.build(name: 'Round Robin',is_return: is_back_turn, round_detail_id: round_detail.id)
      @round.save!
      @tour.teams.to_a.each do |team|
        @round.ranks.build(team_id: team.id).save!
      end
      if is_back_turn
        (total_teams * (total_teams - 1)).times do |n|
          @round.matches.build(turn: n, place: Faker::Address.city, time: DateTime.now + n + 1).save!
        end
        @teams = @tour.teams.to_a
        @matches = @round.matches.to_a
        j = 0
        2.times do
          @teams.each_with_index  do |team, i|
            ((i + 1)..(@teams.size - 1)).map do |n|
              team.results.build(match_id: @matches[j].id).save!
              @teams[n].results.build(match_id: @matches[j].id).save!
              j += 1
            end
          end
        end
      else
        (total_teams * (total_teams - 1) / 2).times do |n|
          @round.matches.build(turn: n, place: Faker::Address.city, time: DateTime.now + n + 1).save!
        end
        @teams = @tour.teams.to_a
        @matches = @round.matches.to_a
        j = 0
        @teams.each_with_index  do |team, i|
          (i + 1)..@teams.size do |n|
            team.results.build(match_id: @matches[j].id).save!
            @teams[n].results.build(match_id: @matches[j].id).save!
            j += 1
          end
        end
      end
    end
  end
end
