class Admin::StaticticalsController < ApplicationController
  layout 'admin/application'

  def index
    @tour = Tournament.find_by(id: params[:id])
    @rounds = @tour.rounds.includes(:ranks)
    @players = @tour.players.left_joins(:events).where('events.event_detail_id = 1')
                                           .group(:id).order('COUNT(events.id) DESC').limit(10)
  end
end
