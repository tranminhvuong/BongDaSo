class Admin::PostsController < ApplicationController
  layout 'admin/application'
  before_action :logged_in_user, only: %i[index show new create edit update destroy]
  def index
    if admin?
      @posts = Post.includes(:user).paginate(page: params[:page], per_page: 5).order('created_at DESC')
    else
      @posts = current_user.posts.paginate(page: params[:page], per_page: 5).order('created_at DESC')
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      return render partial: 'layouts/admin/not_found'
    
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      return render partial: 'layouts/admin/not_found'
    
    end
  end

  def new
    @categories = Category.all
    @post = Post.new
  end

  def destroy
    post = Post.find_by(id: params[:id])
    post&.destroy
    render json: { result: 'success' }
  end

  def create
    post_params[:content].html_safe
    @post = current_user.posts.build(post_params)
    if @post.save!
      # Handle a successful save.
      redirect_to admin_posts_path
    else
      render :new
    end
  end

  def publiced
    post = Post.find_by(id: params[:id])
    post&.update_attributes(status: true)
    render json: { result: post.status }
  end

  def privated
    post = Post.find_by(id: params[:id])
    post&.update_attributes(status: false)
    render  json: { result: post.status }
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post
      if @post.update_attributes(post_params)
        redirect_to admin_post_path(@post)
      else
        render :edit
      end
    else
      render 'layout/admin/errors'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category_id, :status)
  end
end
