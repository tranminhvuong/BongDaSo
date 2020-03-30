class SchedulesController < ApplicationController
  layout 'public/application'

  def index
    @now = Time.zone.now
    @week = []
    @week << @now
    6.times { @week << @week.last.next_day }
    if params[:time]
      start = @now.beginning_of_day + 3600 * 24 * (params[:time].to_i)
      end_time = @now.end_of_day + 3600 * 24 * (params[:time].to_i)
      @tours = Tournament.includes(:matches, :teams).where("tournaments.time_end > ?", @now).joins(:rounds).joins(:matches).where('matches.time BETWEEN ? AND ?', start, end_time )
    else
      start = @now.beginning_of_day
      end_time = @now.end_of_day + 3600 * 24 * 6
      @tours = Tournament.includes(:matches, :teams).where("tournaments.time_end > ?", @now).joins(:rounds).joins(:matches).where('matches.time BETWEEN ? AND ?', start, end_time )
    end
  end
end
