class FamilyController < ApplicationController
  before_filter :authenticate_person!
  before_action :set_family, only: [:show, :about_us]

  def new
    @family = Family.new
    respond_to do |f|
      f.html
      f.js
    end
  end

  def add_member_input
    respond_to do |f|
      f.js
    end
  end

  def show 
  end

  def create
    binding.pry
    @family = Family.create(family_params)
    redirect_to family_path(@family)
  end

  def about_us
  end

  private

  def set_family
    @family = Family.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name)
  end
end
