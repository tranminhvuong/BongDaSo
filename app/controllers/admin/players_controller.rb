class Admin::PlayersController < ApplicationController
  layout 'admin/application'
  before_action :logged_in_user, :admin_user, only: %i[index show edit update destroy]
  def index
    @players = Player.paginate(page: params[:page], per_page: 5)
  end

  def show
    @player = Player.includes(:events).find_by(id: params[:id])
    if @player.nil?
      return render partial: 'layouts/admin/not_found'
    
    end
  end

  def edit
    @player = Player.find_by(id: params[:id])
    if @player.nil?
      return render partial: 'layouts/admin/not_found'
    
    end
  end

  def new
    @player = Player.new
    @team = Team.find_by(id: params[:team_id])
    if @team.nil?
      return render partial: 'layouts/admin/not_found'

    end
  end

  def destroy
    player = Player.find_by(id: params[:id])
    player&.destroy
    render json: { result: 'success' }
  end

  def create
    @team = Team.find_by(id: params[:team_id])
    if @team
      @player = @team.players.build(player_params)
      if @player.save!
        # Handle a successful save.
        redirect_to admin_team_path(@team)
      else
        render :new
      end
    else
      return render partial: 'layouts/admin/not_found'

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
    params.require(:player).permit(:name, :number, :position, :avatar)
  end
end
