class FamilyController < ApplicationController
  before_filter :authenticate_person!

  def index
  end

  def new
    @family = Family.new
  end

  def show
    @family = Family.find(params[:id])
  end

  def create
    binding.pry
  end

end
