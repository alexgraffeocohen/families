class FamilyController < ApplicationController
  def index
    @family = current_user.families[0]
  end
end
