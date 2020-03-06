class Admin::TournamentsController < ApplicationController
  layout 'admin/application'
  def index
    @tournaments = Tournament.paginate(page: params[:page], per_page: 5)
  end

  def show
    @tournament = Tournament.find_by(id: params[:id])
  end
end
