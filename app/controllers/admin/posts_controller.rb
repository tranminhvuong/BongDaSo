class Admin::PostsController < ApplicationController
  layout 'admin/application'
  def index
    @posts = Post.paginate(page: params[:page], per_page: 5).order('created_at DESC')
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def new
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
    params.require(:post).permit(:title, :content, :category, :status)
  end
end
