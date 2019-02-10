class ApplicationController < ActionController::Base
  before_action :set_paper_trail_whodunnit
  # before_action :authenticate_user!
  before_action :set_locale
  before_action :set_array_menu
  before_action :set_search_form
  before_action :set_right_menu
  before_action :set_left_menu
  before_action :configure_permitted_parameters, if: :devise_controller?
  respond_to :json, :html

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json {head :forbidden, content_type: 'text/html'}
      format.html {redirect_to main_app.root_url, alert: exception.message}
      format.js {head :forbidden, content_type: 'text/html'}
    end
  end

  layout :layout_by_resource

  def set_array_menu
    @array_menu = %w(posts followers chats blocked_users)
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
      @friendships = Friendship.where(accepted: true).
        where('friendships.receiver_id = ? OR friendships.user_id = ? ', current_user.id, current_user.id)
    end
  end

  def set_locale
    session[:locale] = params[:locale] if params[:locale].present?
    I18n.locale = session[:locale] || I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    keys = [:avatar, :username, :first_name, :last_name, :public_profile,
            :reason_to_be_disabled, :latitude, :longitude,
            contact_attributes: [:id, :email, :phone, :_destroy],
            address_attributes: [:id, :cep, :street, :number, :complement, :_destroy]
    ]
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
  end

  def layout_by_resource
    if devise_controller?
      if action_name == 'new' or action_name == 'reenable'
        'public'
      else
        'devise_edit_user'
      end
    else
      'application'
    end
  end
end
