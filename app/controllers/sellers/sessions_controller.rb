# frozen_string_literal: true

class Sellers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  # POST /resource/sign_in
  def create
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  # DELETE /resource/sign_out
  def destroy
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
