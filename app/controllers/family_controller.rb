class FamilyController < ApplicationController
  include FamilyHelper
  include PeopleHelper
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
    # family is created
    @family = Family.create(family_params)
    @family.person_families.build(person: current_person)

    accounts = create_accounts(params, @family)
    nested_array = members_array(accounts, params[:people][:relations])
    set_relations(rearrange_members(nested_array), current_person)
    # if he added family members
      # create new accounts for each email inputted
      # two attributes are created... email and gender
      # all new accounts are assigned to the family just created
      # grab relationships for each family and set two-way relationships for  the admin and the family member that was entered
    # new members are emailed to confirm their account. they have all their information set with the exception of their first_name, password, birthday
    # admin is redirected to the newly created family page
    # new accounts confirm via email token and are redirected on confirmation to family page that was created by the admin.
    redirect_to family_path(@family)
  end

  def about_us
  end

  def invite_members
    @members.each do |member|
      WelcomeMailer.invite(member.email).deliver
    end
  end

  private

  def set_family
    @family = Family.friendly.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name)
  end
end
