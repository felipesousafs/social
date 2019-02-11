class Users::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:index, :friendship_requests, :my_timeline, :nearby]
  load_and_authorize_resource

  def index;
  end

  def show;
    respond_to do |format|
      format.html
      format.json {render json: {id: @user.id, email: @user.email, address: @user.addresses.first&.street, latitude: @user.latitude, longitude: @user.longitude}}
    end
  end

  def follow
    if @user.followers.create(follower_id: current_user.id)
      respond_to do |format|
        format.html {redirect_to users_path, notice: "Agora você está seguindo #{@user}."}
        format.json {render json: {notice: "Agora você está seguindo #{@user}."}}
      end
    else
      respond_to do |format|
        format.html {redirect_to action: :index, alert: "Falha ao seguir #{@user}."}
        format.json {render json: {alert: "Falha ao seguir #{@user}."}}
      end
    end
  end

  def unfollow
    if @user.followers.find_by(follower_id: current_user.id).destroy
      respond_to do |format|
        format.html {redirect_to users_path, notice: "Você deixou de seguir #{@user}."}
        format.json {render json: {notice: "Você deixou de seguir #{@user}."}}
      end
    else
      respond_to do |format|
        format.html {redirect_to action: :index, alert: "Falha ao tentar deixar de seguir #{@user}."}
        format.json {render json: {alert: "Falha ao tentar deixar de seguir #{@user}."}}
      end
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
    if @user.add_role :admin
      redirect_to users_path, notice: 'Superuser adicionado com sucesso.'
    else
      redirect_to action: :index, alert: 'Falha ao adicionar superuser.'
    end
  end

  def remove_superuser
    if @user.remove_role :admin
      redirect_to users_path, notice: 'Superuser removido com sucesso.'
    else
      redirect_to action: :index, alert: 'Falha ao adicionar superuser.'
    end
  end

  def my_timeline
    @posts = current_user.posts.page(params[:page])
  end

  def nearby
    if current_user
      @nearby_users = current_user.get_nearby_users
      respond_to do |format|
        format.html
        format.json {render json: @nearby_users, status: 201}
      end
    end
  end

  def destroy_location
    @user.destroy_my_location
    respond_to do |format|
      format.html {redirect_to @user, notice: "Localização removida."}
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
