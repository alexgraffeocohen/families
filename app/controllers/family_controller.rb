class FamilyController < ApplicationController
  before_filter :authenticate_person!

  def index

  end

  def create
    binding.pry
  end
end
