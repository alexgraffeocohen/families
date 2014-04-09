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
    @family = Family.create(family_params)
    redirect_to family_path(@family)
  end

  private

  def family_params
    params.require(:family).permit(:name)
  end
end
