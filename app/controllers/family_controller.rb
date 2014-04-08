class FamilyController < ApplicationController
  before_filter :authenticate_person!
  before_action :set_family, only: [:show]

  def index
  end

  def new
    @family = Family.new
  end

  def show
  end

  def create
    binding.pry
  end

  private

  def set_family
    @family = Family.find(params[:id])
  end
end
