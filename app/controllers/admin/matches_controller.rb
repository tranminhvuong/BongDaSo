class Admin::MatchesController < ApplicationController
  layout 'admin/application'

  def index
    @tournament = Tournament.find_by(id: params[:tournament_id])
    @matches = @tournament.matches.to_a.sort_by!(&:id)
  end

  def show
    @match = Match.includes(:results).find_by(id: params[:id])
  end

  def edit
    @match = Match.includes(:results).find_by(id: params[:id])
  end

  def update
    @match = Match.find_by(id: params[:id])
    if @match&.update_attributes(match_params)
      redirect_to admin_tournament_match_path(@match.tournament, @match)
    else
      render :edit
    end
  end

  private

  def match_params
    params.require(:match).permit(:time, :place)
  end
end
