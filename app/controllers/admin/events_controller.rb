class Admin::EventsController < ApplicationController
  layout 'admin/application'
  before_action :logged_in_user, :admin_user, only: %i[index show new create edit update destroy]

  def create
    @event = Event.new(event_params)
    if @event.save!
      render json: { status: @event, player: @event.player.name, detail: @event.event_detail.name, minute: @event.minute }
    else
      render json: { status: 'not created' }
    end
  end

  private

  def event_params
    params.require(:event).permit(:player_id, :event_detail_id, :result_id, :minute)
  end
end