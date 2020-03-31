class Admin::UsersController < ApplicationController
  layout 'admin/application'
  before_action :logged_in_user, :admin_user, only: %i[index edit update destroy]
  before_action :correct_user,   only: %i[edit update]

  def show
    @user = User.includes(:posts).find_by(id: params[:id])
    if @user.nil?
      return render partial: 'layouts/admin/not_found'
    
    end
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def edit
    @user = User.find_by(id: params[:id])
    if @user.nil?
      return render partial: 'layouts/admin/not_found'
    
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user
      if @user.update_attributes(update_user_params)
        redirect_to admin_user_path(@user)
      else
        render :edit
      end
    else
      render 'layout/admin/errors'
    end
  end

  def index
    @users = User.includes(:posts).paginate(page: params[:page], per_page: 5).order('created_at DESC')
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user
      user.destroy
      flash[:success] = 'User deleted'
      redirect_back_or admin_users_url
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                 :avatar, :role_id)
  end

  def update_user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :avatar, :role_id)
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    if !@user
      flash[:notice] = 'could not find user!'
      redirect_to admin_users_path
    elsif !current_user?(@user)
      flash[:notice] = 'could not update user!'
      redirect_to admin_users_path
    end
  end
end
