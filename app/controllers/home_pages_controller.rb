class HomePagesController < ApplicationController
  layout 'public/application'
  def index
    @posts = Post.includes(:user).with_rich_text_content_and_embeds.where(status: true).limit(5).order('created_at DESC').to_a
    @popular_posts = Post.includes(:user).with_rich_text_content_and_embeds.where(status: true).limit(8).order('count_views DESC').to_a
    @popular_first_posts = @popular_posts.slice!(0,2)
    time = Time.zone.now
    @today_matches = Match.includes(:teams, :results, :tournament).where("time BETWEEN ? AND ?", time.beginning_of_day, time.end_of_day)
    @last_matches = Match.includes(:teams, :results, :tournament).where("time BETWEEN ? AND ?", time.yesterday.beginning_of_day, time.yesterday.end_of_day)
    @round = Round.includes(:ranks, :teams, :tournament).order(Arel.sql('RANDOM()')).first
    @ranks = @round.ranks.order(goals_for: 'DESC') 
  end
end
