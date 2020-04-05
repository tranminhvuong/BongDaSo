class Admin::StaticticalsController < ApplicationController
  layout 'admin/application'
  before_action :logged_in_user, :admin_user, only: %i[index show new create edit update destroy]

  def index
    @tour = Tournament.find_by(id: params[:id])
    @rounds = @tour.rounds.includes(ranks: :team).to_a
    @players = @tour.players.includes(:team, :events).left_joins(:events).where('events.event_detail_id = 1')
                                           .group(:id).order('COUNT(events.id) DESC').limit(10).to_a
  end
end
