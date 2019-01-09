class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :set_array_menu
  before_action :set_search_form
  before_action :set_right_menu
  before_action :set_left_menu
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  layout :layout_by_resource

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

  protected

  def configure_permitted_parameters
    keys = [:username, :first_name, :last_name, :public_profile,
            contact_attributes: [:id, :email, :phone, :_destroy],
            address_attributes: [:id, :cep, :street, :number, :complement, :_destroy]
    ]
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
  end

  def layout_by_resource
    if devise_controller?
      if action_name == 'new'
        'public'
      else
        'devise_edit_user'
      end
    else
      'application'
    end
  end
end
