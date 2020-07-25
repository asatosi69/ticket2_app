# frozen_string_literal: true

class Sellers::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  # POST /resource/password
  def create
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  # PUT /resource/password
  def update
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  # protected

  def after_resetting_password_path_for(resource)
    @subdomain = request.subdomain.to_s.to_sym
    super(resource)
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    @subdomain = request.subdomain.to_s.to_sym
    super(resource_name)
  end
end
