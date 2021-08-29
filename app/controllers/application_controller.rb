# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || books_path
  end

  def after_sign_out_path_for(scope)
    scope = Devise::Mapping.find_scope!(scope)
    router_name = Devise.mappings[scope].router_name
    context = router_name ? send(router_name) : self
    context.respond_to?(:root_path) ? context.root_path : new_session_path(scope)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[postcode address self_introduction])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[postcode address self_introduction])
  end
end
