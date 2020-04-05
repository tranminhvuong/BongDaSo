class PostsController < ApplicationController
  layout 'public/application'

  def index
    @categories = Category.all.to_a
    if params[:category]
      @posts = Post.includes(:user).with_rich_text_content_and_embeds.pub.cate(params[:category]).paginate(page: params[:page], per_page: 5).order('created_at DESC').to_a
    else
      @posts = Post.includes(:user).with_rich_text_content_and_embeds.pub.paginate(page: params[:page], per_page: 5).order('created_at DESC').to_a
    end
    @recent_posts = Post.includes(:user).with_rich_text_content_and_embeds.pub.limit(5).order('created_at DESC')
  end

  def show
    @categories = Category.all.to_a
    @recent_posts = Post.includes(:user).with_rich_text_content_and_embeds.where(status: true).limit(5).order('created_at DESC')
    @post = Post.where(status: true).find_by(id: params[:id])
    if @post
      @post.increment!(:count_views)
    end
  end
end
