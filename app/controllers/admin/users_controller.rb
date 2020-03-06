class Admin::UsersController < ApplicationController
  layout 'admin/application'
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :has_permison,   only: [:destroy]

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user
      if @user.update_attributes(user_params)
        redirect_to admin_user_path(@user)
      else
        render :edit
      end
    else 
      render 'layout/admin/errors'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a successful save.
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user 
      user.destroy    
      flash[:success] = "User deleted"
      redirect_to admin_users_url
    end
  end

  def index
    @users = User.paginate(page: params[:page].order('created_at DESC', per_page: 5)
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find_by(id: params[:id])
      if !@user
        flash[:notice] = "could not find user!"
        redirect_to admin_users_path
      elsif !current_user?(@user)
        flash[:notice] = "could not update user!"
        redirect_to admin_users_path
      end
    end

    def has_permison
      # check xem thuwr co quyen ko?
      unless current_user.permisions.pluck(:permision).include?("update_user")
        redirect_to(root_url)
      end
    end
end
