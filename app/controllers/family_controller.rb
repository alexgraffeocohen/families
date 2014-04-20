class FamilyController < ApplicationController
  include FamilyHelper
  include PeopleHelper
  include Permissable
  before_filter :authenticate_person!
  before_action :set_family, only: [:show, :about_us, :add_admin, :destroy, :confirm_destroy, :modify_families, :add_names]

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

  def add_names
    @person = Person.new
  end

  def modify_families
    rels = params[:people][:relations]
    if request.referrer.include?("add_names")
      result = any_invalid?(rels, current_person.current_relationships)
      if result == false
        send_invites(rels)
      else
        respond_to do |f|
          f.js   {render 'members_invalid', locals: {msge: generate_invalid_alert(result)} }
        end
      end
    else
      send_invites(rels)
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
    flash[:notice] = "Admins have been assigned."
    redirect_to root_path
  end

  def show 
  end

  def create
    result = any_invalid?(params["people"]["relations"])
    if result == false 
        @family = Family.find_or_create_by(family_params)
        @family.person_families.build(person: current_person)
        modify_families
    else
      @family = Family.new
      respond_to do |f|
        f.js   {render 'members_invalid', locals: {msge: generate_invalid_alert(result)} }
        f.html { render 'new', :alert => generate_invalid_alert(result) }
      end
    end
  end

  def destroy
    @family.destroy
    redirect_to root_path
  end

  def about_us
  end

  private

  def send_invites(rels)
    accounts = create_accounts(params, @family)
    nested_array = members_array(accounts, rels)
    set_relations(rearrange_members(nested_array), current_person)
    render :js => "window.location='#{family_path(@family)}'"
    flash[:notice] = "Invitations have been sent."
  end

  def validation_hash
    {
      :full_match_needed => {
        "maternal grandmother" => ["mother"],
        "maternal grandfather" => ["mother"],
        "paternal grandmother" => ["father"],
        "paternal grandfather" => ["father"],
      },
      :partial_match_needed => {
        "sister" => ["father", "mother"],
        "brother" => ["father", "mother"],
        "maternal aunt"  => ["maternal grandmother", "maternal grandfather", "mother"],
        "paternal aunt"  => ["paternal grandmother", "paternal grandfather", "father"],
        "maternal uncle" => ["maternal grandmother", "maternal grandfather", "mother"],
        "paternal uncle" => ["paternal grandmother", "paternal grandfather", "father"],
        "father-in-law"  => ["husband", "wife"],
        "mother-in-law"  => ["husband", "wife"]
      } 
    }
  end

  def any_invalid?(requested_relations, current_relations = nil)
    current_relations ||= requested_relations
    switch = false

    validation_hash[:full_match_needed].each do |key, value|
      if requested_relations.include?(key) && (current_relations & value).length != value.length
        switch = key
      end
    end

    validation_hash[:partial_match_needed].each do |key, value|
      if requested_relations.include?(key) && (current_relations & value).length < 1
        switch = key
      end
    end

    switch
  end

  def generate_invalid_alert(result)
    message = ""
    validation_hash[:full_match_needed].each do |key, value|
      if result == key
        message = "To add a #{key}, please also add #{value[0]}"
      end
    end

    validation_hash[:partial_match_needed].each do |key, value|
      if result == key
        message = "To add a #{key}, please also add 
        #{if value[2]
          value[0]+' or '+value[1]+' and '+value[2]
        elsif value[1]
          value[0]+' or '+value[1]
        end }"
      end
    end

    message
  end

  def set_family
    @family = Family.friendly.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name)
  end
end
