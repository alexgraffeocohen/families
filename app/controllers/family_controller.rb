class FamilyController < ApplicationController
  before_filter :authenticate_person!
  before_action :set_family, only: [:show, :about_us]

  def index
  end

  def new
    @family = Family.new
  end

  def show
    @family = Family.find(params[:id])
  end

  def create
  end

  def about_us
  end

end
