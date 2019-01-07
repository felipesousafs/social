class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.has_role? :admin
      @posts = Post.page(params[:page])
    else
      @posts = current_user.followed_posts.page(params[:page])
    end
  end
end
