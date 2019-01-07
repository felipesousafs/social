class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:index, :friendship_requests, :accept_friendship]

  def index; end

  def show;
  end

  def follow
    if @user.followers.create(follower_id: current_user.id)
      redirect_to users_path, notice: 'Success.'
    else
      redirect_to action: :index, alert: 'Failed to follow this user.'
    end
  end

  def unfollow
    if @user.followers.find_by(follower_id: current_user.id).destroy
      redirect_to users_path, notice: 'Success'
    else
      redirect_to action: :index, alert: 'Failed to unfollow this user.'
    end
  end

  def disable
    # TODO
  end

  def send_friendship
    # TODO: add "false" as default to 'accepted'
    if current_user.friendships.create(receiver_id: @user.id, accepted: false)
      redirect_to users_path, notice: 'Success.'
    else
      redirect_to action: :index, alert: 'Failed to add this user.'
    end
  end

  def accept_friendship
    @request = Friendship.find(params[:id])
    if @request.update(accepted: true)
      redirect_to friendships_path, notice: 'Success.'
    else
      redirect_to friendships_path, alert: 'Failed to accept request.'
    end
  end

  def friendship_requests
    @friendship = Friendship.where.not(accepted: true)
    @received_requests = @friendship.where(receiver_id: current_user.id)
    @sent_requests = @friendship.where(user_id: current_user.id)
  end

  def block_user
    if current_user.blocked_users.create(blocked_id: @user.id)
      redirect_to users_path, notice: 'Success.'
    else
      redirect_to users_path, alert: 'Failed to block this user.'
    end
  end

  def unblock_user
    block = current_user.blocked_users.find_by(blocked_id: @user.id)
    if block.destroy
      redirect_to users_path, notice: 'Success.'
    else
      redirect_to users_path, alert: 'Failed to unblock this user.'
    end
  end

  def add_superuser
    # TODO
  end

  def remove_superuser
    # TODO
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
