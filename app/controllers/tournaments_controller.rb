class TournamentsController < ApplicationController
  layout 'public/application'

  def index
    @tours = Tournament.includes(:teams, :rounds).finish(params[:status]).paginate(page: params[:page], per_page: 5)
  end

  def show
    @tour = Tournament.includes(:teams, :players).find(params[:id])
    @ranks = @tour&.ranks.includes(:team)
    start = Time.zone.now.beginning_of_day
    end_time = Time.zone.now.end_of_day + 3600 * 24
    @matches = @tour.matches.includes(:teams, :results).where('matches.time BETWEEN ? AND ?', start, end_time )
  end
end
