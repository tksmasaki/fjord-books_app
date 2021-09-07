# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_update_path_for(resource)
    sign_in_after_change_password? ? user_path(resource) : new_session_path(resource_name)
  end
end
