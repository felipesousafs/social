class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.has_role? :admin
      @posts = Post.page(params[:page])
    else
      @posts = current_user.followed_posts.page(params[:page])
    end
  end

  def admin
    @q = User.ransack(params[:q])
    @all_users = @q.result(distinct: true)
    @versions = PaperTrail::Version.where(whodunnit: (User.with_role(:admin).pluck(:id))).order(created_at: :desc)
    @users_last_month = @all_users.where(created_at: Date.today - 1.month..Date.today.at_end_of_day)
    @total_posts = Post.all
    @posts_last_month = @total_posts.where(created_at: Date.today - 1.month..Date.today.at_end_of_day)
    authorize! :read, :admin
  end
end
