class Admin::MatchesController < ApplicationController
  layout 'admin/application'

  def index
    @tour = Tournament.find_by(id: params[:tournament_id])
    @matches = @tour.matches.to_a.sort_by!(&:time)
  end

  def edit
    @tour = Tournament.find_by(id: params[:tournament_id])
    @match = Match.includes(:results).find_by(id: params[:id])
  end

  def update
    @match = Match.find_by(id: params[:id])
    now = DateTime.now
    time = @match&.time
    if time
      if time < now
        update_result
      else
        update_infor
      end
    else
      render :edit
    end
  end

  private

  def match_params
    params.require(:match).permit(:time, :place)
  end

  def update_result
    
  end

  def update_infor
    if @match&.update_attributes(match_params)
      redirect_to admin_tournament_matches_path(@match.tournament)
    else
      render :edit
    end
  end
end
