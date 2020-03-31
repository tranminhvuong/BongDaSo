class TeamsController < ApplicationController
  layout 'public/application'

  def show
    @team = Team.includes(:matches, :players).find(params[:id])
  end
end
