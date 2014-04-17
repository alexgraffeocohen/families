class FamilyController < ApplicationController
  include FamilyHelper
  include PeopleHelper
  include Permissable
  before_filter :authenticate_person!
  before_action :set_family, only: [:show, :about_us, :add_admin, :destroy]

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

  def add_admin
  end

  def create_admin
    ids = params[:add_admin].split(" ")
    ids.each do |id|
      person = Person.where("id = ?", id.to_i)[0]
      person.admin = 1
      person.save
    end
    redirect_to root_path
  end

  def show 
  end

  def create
    # family is created
    @family = Family.create(family_params)
    @family.person_families.build(person: current_person)

    accounts = create_accounts(params, @family)
    nested_array = members_array(accounts, params[:people][:relations])
    set_relations(rearrange_members(nested_array), current_person)
    redirect_to family_path(@family)
  end

  def destroy
    @family.people.destroy_all
    redirect_to new_person_session_path
  end

  def invite_members
    @members.each do |member|
      WelcomeMailer.invite(member.email).deliver
    end
  end

  def about_us
  end

  private

  def set_family
    @family = Family.friendly.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name)
  end
end
