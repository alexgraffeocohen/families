class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # def after_sign_in_path_for(resource)
  #   current_user_path
  # end
  
  private
    def configure_permitted_parameters
      [:first_name, :age, :birthday, :data].each do |param|
        devise_parameter_sanitizer.for(:sign_up) << param
        devise_parameter_sanitizer.for(:account_update) << param
      end
    end
end
