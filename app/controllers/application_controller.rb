class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :set_array_menu
  before_action :set_search_form

  def set_array_menu
    @array_menu = %w(posts friendships followers chats blocked_users)
  end

  def set_search_form
    @q = User.ransack(params[:q])
    @listed_users = @q.result(distinct: true)
  end
end
