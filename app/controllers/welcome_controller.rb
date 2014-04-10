class WelcomeController < ApplicationController
  def index
    if person_signed_in?
      if current_person.families.empty?
        redirect_to new_family_path
      else
        redirect_to family_path(current_person.default_family)
      end
    end
  end
end
