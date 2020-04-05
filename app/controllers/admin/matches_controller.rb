class Admin::MatchesController < ApplicationController
  layout 'admin/application'
  before_action :logged_in_user, :admin_user , only: %i[index show new create edit update destroy]

  def index
    if params[:status]
      @matches = tour.matches.include_details.status_match(params[:status]).order(time: :desc).paginate(page: params[:page], per_page: 10).to_a
    else
      @matches = tour.matches.include_details.order(time: :desc).paginate(page: params[:page], per_page: 10).to_a
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
        @results = @match.results.includes(team: :logo_attachment).to_a
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
      end_match
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

  def end_match
    results = @match.results.to_a
    team_first = results.first.team
    team_last = results.last.team
    result_first = results.first.events.joins(:event_detail).where(event_details: {name: 'goal'}).size
    result_last = results.last.events.joins(:event_detail).where(event_details: {name: 'goal'}).size
    if result_first == result_last
      @match.update_attributes(winner_id: 0)
      update_rank(team_first, team_last, result_first, result_last, 1)
    elsif result_first > result_last
      @match.update_attributes(winner_id: team_first.id)
      update_rank(team_first, team_last, result_first, result_last)
    else
      @match.update_attributes(winner_id: team_last.id)
      update_rank(team_last, team_first, result_last, result_first)
    end
  end

  def update_rank(team_win, team_lose, result_win, result_lose, *draw)
    rank_team_win = team_win.ranks.find_by(round_id: @match.round_id)
    rank_team_lose = team_lose.ranks.find_by(round_id: @match.round_id)
    if draw.any?
      rank_team_win.increment!(:draw)
      rank_team_win.increment!(:score)
      rank_team_lose.increment!(:draw)
      rank_team_win.increment!(:score)
    else
      rank_team_win.increment!(:win)
      rank_team_lose.increment!(:lose)
      rank_team_win.update_attributes(score: rank_team_win.score + 3) 
    end
    rank_team_win.update_attributes(goals_for: rank_team_win.goals_for + result_win,
                                     goals_against: rank_team_win.goals_against + result_lose)
    rank_team_lose.update_attributes(goals_for: rank_team_lose.goals_for + result_lose,
                                     goals_against: rank_team_lose.goals_against + result_win)
  end
end
