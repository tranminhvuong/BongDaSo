class Admin::PlayersController < ApplicationController
  layout 'admin/application'
  before_action :logged_in_user, :admin_user, only: %i[index show edit update destroy]
  def index
    @players = Player.paginate(page: params[:page], per_page: 5)
  end

  def show
    @player = Player.find_by(id: params[:id])
  end

  def edit
    @player = Player.find_by(id: params[:id])
  end

  def new
    @positions = Position.all
    @player = Player.new
  end

  def destroy
    player = Player.find_by(id: params[:id])
    player&.destroy
    render json: { result: 'success' }
  end

  def create
    @positions = Position.all
    @player = Player.new(player_params)
    if @player.save
      # Handle a successful save.
      redirect_to admin_players_path
    else
      render :new
    end
  end

  def update
    @player = Player.find_by(id: params[:id])
    if @player
      if @player.update_attributes(player_params)
        redirect_to admin_player_path(@player)
      else
        render :edit
      end
    else
      render 'layout/admin/errors'
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :date_of_birth, :address, :position_id, :team_id)
  end
end
