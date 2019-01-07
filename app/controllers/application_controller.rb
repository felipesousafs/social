class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :set_array_menu
  before_action :set_search_form
  before_action :set_right_menu
  before_action :set_left_menu

  def set_array_menu
    @array_menu = %w(posts friendships followers chats blocked_users)
  end

  def set_search_form
    @q = User.ransack(params[:q])
    @listed_users = @q.result(distinct: true)
  end

  def set_right_menu
    if user_signed_in?
      @friendship = Friendship.where.not(accepted: true)
      @received_requests = @friendship.where(receiver_id: current_user.id)
      @sent_requests = @friendship.where(user_id: current_user.id)
    end
  end

  def set_left_menu
    if user_signed_in?
      @friendships = Friendship.where(accepted: true)
    end
  end
end
