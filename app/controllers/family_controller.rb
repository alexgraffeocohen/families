class FamilyController < ApplicationController
  before_filter :authenticate_person!
  before_action :set_family, only: [:show, :about_us]

  def new
    @family = Family.new
  end

  def show 
  end

  def create
    @family = Family.create(family_params)
    redirect_to family_path(@family)
  end

  def about_us
  end

  private

  def set_family
    @family = Family.find(params[:id])
  end

  private

  def family_params
    params.require(:family).permit(:name)
  end
end
