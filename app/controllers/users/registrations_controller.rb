# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    if params[:commit] == "Desativar minha conta"
      if account_update_params[:reason_to_be_disabled].present?
        ActiveRecord::Base.transaction do
          resource.soft_delete
          Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
          set_flash_message :notice, :destroyed
          yield resource if block_given?
          respond_with_navigational(resource) {redirect_to after_sign_out_path_for(resource_name)}
          flash[:notice] = 'Conta desativada com sucesso.'
        end
      else
        flash[:error] = 'Informe a justificativa para desativação da conta.'
        redirect_to edit_user_registration_path
      end
    else
      super
    end
  end

  def reenable;
  end

  def confirm_reenable
    if params[:email].present?
      user = User.find_by_email(params[:email])
      if user
        if user.disabled_at
          user.update(disabled_at: nil)
          redirect_to new_user_session_path, notice: 'Tudo pronto! Sua conta foi reativada e você já pode efetuar login.'
        else
          redirect_to reenable_path, alert: 'O usuário informado não possui conta desativada.'
        end
      else
        redirect_to reenable_path, alert: 'Usuário não encontrado.'
      end
    else
      redirect_to reenable_path, alert: 'Informe o email.'
    end
  end

  # DELETE /resource
  # def destroy
  # resource.soft_delete
  # Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
  # set_flash_message :notice, :destroyed
  # yield resource if block_given?
  # respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
