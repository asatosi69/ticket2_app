# frozen_string_literal: true

class Sellers::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  
  # GET /resource/sign_up
  def new
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  # POST /resource
  def create
    @subdomain = request.subdomain.to_s
    Rails.logger.info @subdomain
    @token = resource.generate_confirmation_token!
    UserMailer.confirmation_instructions(resource, @token, {subdomain: @subdomain})
  end

  # GET /resource/edit
  def edit
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  # PUT /resource
  def update
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  # DELETE /resource
  def destroy
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    @subdomain = request.subdomain.to_s.to_sym
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    @subdomain = request.subdomain.to_s.to_sym
    super(resource)
  end
end
