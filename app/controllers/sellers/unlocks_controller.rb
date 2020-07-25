# frozen_string_literal: true

class Sellers::UnlocksController < Devise::UnlocksController
  # GET /resource/unlock/new
  def new
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  # POST /resource/unlock
  def create
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  # GET /resource/unlock?unlock_token=abcdef
  def show
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  protected

  # The path used after sending unlock password instructions
  def after_sending_unlock_instructions_path_for(resource)
    @subdomain = request.subdomain.to_s.to_sym
    super(resource)
  end

  # The path used after unlocking the resource
  def after_unlock_path_for(resource)
    @subdomain = request.subdomain.to_s.to_sym
    super(resource)
  end
end
