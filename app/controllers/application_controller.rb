class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  private
  
  def configure_permitted_parameters
    #this is a total security risk. need to revisit.
      [:first_name, :age, :birthday, :data, :admin, :gender, :profile_photo].each do |param|
      devise_parameter_sanitizer.for(:sign_up) << param
      devise_parameter_sanitizer.for(:account_update) << param
    end
  end

  def find_family(slug)
    Family.find_by(name_slug: slug)
  end
end
