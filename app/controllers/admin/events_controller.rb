class Admin::EventsController < ApplicationController
  layout 'admin/application'
  before_action :logged_in_user, :admin_user, only: %i[index show new create edit update destroy]
  before_action :correct_player, only: [:create]

  def create
    @event = Event.new(event_params)
    if @event.save
      if @event.event_detail.name == 'get a yellow card'
        check_number_yellow_card
      else
        if @event.event_detail.name == 'goal'
          @event.result.increment!(:goals)
        end
        render json: { status: @event, player: @event.player.name,  detail: @event.event_detail.name, minute: @event.minute }
      end
      else
      render json: { status: 'error', msg: 'Some thing wrong please check aigain!' }
    end
  end

  private

  def event_params
    params.require(:event).permit(:player_id, :event_detail_id, :result_id, :minute)
  end

  def check_number_yellow_card
    events = Event.joins(:event_detail).where(player_id: @event.player_id, event_details: {name: 'get a yellow card'}).to_a.sort_by!{ |item| item.minute }
    if events.size == 2
      red_card = Event.create(result_id: @event.result_id, player_id: @event.player_id, event_detail_id: 3, minute: events.last.minute)
      return render json: { status: 'bonus', data: @event.result_id, player: @event.player.name, detail: [@event.event_detail.name, red_card.event_detail.name], minute: [@event.minute, red_card.minute]}
    else
      render json: { status: @event, player: @event.player.name,  detail: @event.event_detail.name, minute: @event.minute }
    end
  end

  def correct_player
    red_event = Event.find_by(player_id: params[:event][:player_id], result_id: params[:event][:result_id], event_detail_id: 3)
    if red_event && params[:event][:minute].to_i > red_event.minute
      return render json: { status: "error", msg: "This player got red card. Cannot add more event after him get it" }
    elsif Event.joins(:event_detail).where(player_id: @event.player_id, event_details: {name: 'get a yellow card'}).size == 2
      return render json: { status: "error", msg: "This player got 2 yellow card. Cannot add more yellow card" }
    elsif Event.joins(:event_detail).where(player_id: @event.player_id, event_details: {name: 'get a red card'}).any?
      return render json: { status: "error", msg: "This player got a red card. Cannot add more red card" }
    end
  end
end
