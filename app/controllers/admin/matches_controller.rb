class Admin::MatchesController < ApplicationController
  layout 'admin/application'
  before_action :logged_in_user, :admin_user , only: %i[index show new create edit update destroy]

  def index
    if params[:status]
      @matches = tour.matches.include_details.status_match(params[:status]).order(time: :desc).paginate(page: params[:page], per_page: 10)
    else
      @matches = tour.matches.include_details.order(time: :desc).paginate(page: params[:page], per_page: 10)
    end
  end

  def edit
    @tour = Tournament.find_by(id: params[:tournament_id])
    @match = Match.includes(:results).find_by(id: params[:id])
    if @match && @tour && @tour == @match.tournament
      now = Time.zone.now
      time = @match.time
      if time < now
        @event_details = EventDetail.all
        @event = Event.new
        @results = @match.results
        @n = 0
      end
    else
      return render partial: 'layouts/admin/not_found'

    end
  end

  def show
    @match = Match.find_by(id: params[:id])
    if @match 
      @tour = Tournament.find_by(id: params[:tournament_id]) || @match.round.tournament
      @results = @match.results
    else
      return render partial: 'layouts/admin/not_found'

    end
  end

  def update
    @match = Match.find_by(id: params[:id])
    if params[:tournament_id].nil?
      update_result
    else
      update_infor
    end
  end

  private

  def tour
    @tour ||= Tournament.find_by(id: params[:tournament_id])
  end

  def match_params
    params.require(:match).permit(:time, :place)
  end

  def update_result
    time = Time.zone.now
    if @match&.update_attributes(time_end: time)
      update_rank
      render json: {data: "success"}
    else
      render json: {data: "fail"}
    end
  end

  def update_infor
    if @match&.update_attributes(match_params)
      redirect_to admin_tournament_matches_path(@match.tournament)
    else
      render :edit
    end
  end

  def update_rank
    first_team = @match.teams.first
    last_team = @match.teams.last
    results = @match.results
    rank_first_team = @match.round.ranks.find_by(id: first_team.id)
    rank_last_team = @match.round.ranks.find_by(id: last_team.id)
    # update goal against and goal for
    rank_first_team.update_attributes(goals_for: rank_first_team.goals_for + results.first.goals)
    rank_first_team.update_attributes(goals_against: rank_first_team.goals_against + results.last.goals)
    rank_last_team.update_attributes(goals_for: rank_last_team.goals_for + results.last.goals)
    rank_last_team.update_attributes(goals_against: rank_last_team.goals_against + results.first.goals)
    # update_score and win lose draw
    if @match.winner_id == 0
      rank_last_team.increment!(:score)
      rank_last_team.increment!(:draw)
      rank_first_team.increment!(:score)
      rank_first_team.increment!(:draw)
    elsif first_team.id == @match.winner_id
      rank_first_team.update_attributes!(score: rank_first_team.score + 3)
      rank_first_team.increment!(:win)
      rank_last_team.increment!(:lose)
    else
      rank_last_team.update_attributes!(score: rank_last_team.score + 3)
      rank_first_team.increment!(:lose)
      rank_last_team.increment!(:win)
    end
  end
end
