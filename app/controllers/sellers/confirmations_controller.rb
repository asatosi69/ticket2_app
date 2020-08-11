# frozen_string_literal: true

class Sellers::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  def new
    @subdomain = request.subdomain.to_s.to_sym
    super
  end

  # POST /resource/confirmation
  def create
      @subdomain = request.subdomain.to_s
      super do
        @subdomain = request.subdomain.to_s
        resource.send(:generate_confirmation_token!)
        @token = resource.confirmation_token
        UserMailer.confirmation_instructions(resource, @token, {subdomain: @subdomain})
      end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
     @subdomain = request.subdomain.to_s.to_sym
     super
  end

  # protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
     @subdomain = request.subdomain.to_s.to_sym
     super(resource_name)
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    @subdomain = request.subdomain.to_s.to_sym
    super(resource_name, resource)
  end
end
