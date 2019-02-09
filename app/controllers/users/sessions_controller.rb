# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  after_action :get_token, only: :create
  # GET /resource/sign_in
  def new
    # super
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    @email = sign_in_params[:email]
    @pwd = sign_in_params[:password]
    super
  end

  def get_token
    if current_user
      api = ApiService.new(@email, password: @pwd)
      token = api.get_token
      current_user.update(authentication_token: token)
    end
  end
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
