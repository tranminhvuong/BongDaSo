class Admin::UsersController < ApplicationController
  layout 'admin/application'

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role_id =  1
    if @user.save
      # Handle a successful save.
      redirect_to admin_user_path(@user)
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
    end
end
