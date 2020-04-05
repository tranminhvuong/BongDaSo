class Admin::TeamsController < ApplicationController
  layout 'admin/application'
  before_action :logged_in_user, :admin_user, only: %i[index show edit update destroy]
  def index
    @tour = Tournament.find_by(id: params[:tournament_id])
    if @tour
      @teams = @tour.teams.includes(:players).paginate(page: params[:page], per_page: 4)
    else
      return render partial: 'layouts/admin/not_found'
    end
  end

  def show
    @team = Team.includes(:players, :logo_attachment, :tournament).find_by(id: params[:id])
    if @team
      @players = @team.players.to_a if @team
    else
      return render partial: 'layouts/admin/not_found'

    end
  end

  def edit
    @team = Team.includes(:players, :logo_attachment, :tournament).find_by(id: params[:id])
    if @team.nil?
      return render partial: 'layouts/admin/not_found'
    
    end
  end

  def new
    @team = Team.new
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
    params.require(:team).permit(:name, :tournament_id, :logo, :description)
  end
end
