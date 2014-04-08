class FamilyController < ApplicationController
  before_filter :authenticate_person!

  def index

  end
end
