class Admin::TournamentsController < ApplicationController
  layout 'admin/application'

  VALIDTEAMSTOTAL = [6, 8, 10, 12, 14, 16, 20, 24, 32].freeze

  def index
    @tournaments = Tournament.paginate(page: params[:page], per_page: 5)
  end

  def show
    @tournament = Tournament.find_by(id: params[:id])
  end

  def edit
    @tournament = Tournament.find_by(id: params[:id])
  end

  def new
    @tournament = Tournament.new
  end

  def destroy
    tournament = Tournament.find_by(id: params[:id])
    tournament&.destroy
    render json: { result: 'success' }
  end

  def create
    debugger
    if params[:tournament][:rule] == 'false'
      @tournament = Tournament.new(tournament_params)
      if @tournament.save
        # Handle a successful save.
        redirect_to admin_tournaments_path
      else
        render :new
      end
    elsif VALIDTEAMSTOTAL.include?(params[:tournament][:teams_total].to_i)
      @tournament = Tournament.new(tournament_params)
      if @tournament.save
        # Handle a successful save.
        redirect_to admin_tournaments_path
      else
        render :new
      end
    else
      flash[:notice] = "Invalid teams total please retry with #{VALIDTEAMSTOTAL.join(', ')}!"   
      render :new
    end
  end

  def update
    @tournament = Tournament.find_by(id: params[:id])
    if @tournament
      if @tournament.update_attributes(tournament_params)
        redirect_to admin_tournament_path(@tournament)
      else
        render :edit
      end
    else
      render 'layout/admin/errors'
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, :teams_total, :rule, :turn_back, :time_start, :time_end)
  end
end
