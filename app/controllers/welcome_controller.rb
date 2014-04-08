class WelcomeController < ApplicationController
  def index
    if person_signed_in?
      redirect_to family_path(current_person.default_family)
    end
  end
end
