class Admin::TeamsController < ApplicationController
  layout 'admin/application'
  before_action :logged_in_user, :admin_user, only: %i[index show edit update destroy]
  def index
    @teams = Team.paginate(page: params[:page], per_page: 5)
  end

  def show
    @team = Team.includes(:players).find_by(id: params[:id])
    @players = @team.players.to_a if @team
  end

  def edit
    @team = Team.includes(:players).find_by(id: params[:id])
  end

  def new
    @team = Team.new
  end

  def destroy
    team = Team.find_by(id: params[:id])
    if team&.destroy
      render json: { result: 'success' }
    else
      render json: { result: 'fail' }
    end
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      # Handle a successful save.
      redirect_to admin_teams_path
    else
      render :new
    end
  end

  def add_player
    player = Player.find_by(id: params[:player_id])
    team = Team.find_by(id: params[:id])
    if player&.team_id == 3 && team
      player.update_attributes(team_id: params[:id])
      render json: { result: 'success' }
    else
      render json: { result: 'fail' }
    end
  end

  def remove_player
    player = Player.find_by(id: params[:player_id])
    team = Team.find_by(id: params[:id])
    if team&.id == player&.team_id
      player.update_attributes(team_id: 3)
      render json: { result: 'success' }
    else
      render json: { result: 'fail' }
    end
  end

  def update
    @team = Team.find_by(id: params[:id])
    if @team
      if @team.update_attributes(team_params)
        redirect_to admin_team_path(@team)
      else
        render :edit
      end
    else
      render 'layout/admin/not_found'
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :tournament_id, :logo)
  end
end
