require 'spec_helper'
include Permissable

describe Permissable do
  let(:album) {create(:album, person_id: @marcia.id, family_id: @brady.id)}
  let(:album2) {create(:album, person_id: @carol.id, family_id: @brady.id)}
  let(:album3) {create(:album, person_id: @harold.id, family_id: @brady.id)}
  let(:album4) {create(:album, person_id: @mike.id, family_id: @brady.id)}
  
  before(:each) do
    make_brady_bunch  
  end

  describe "for group checkboxes" do
    it "for siblings" do
      album.permissions = "1"
      expect(@greg.can_see?(album)).to eq(true)
      expect(album.relationships_permitted).to include("brother", "sister")
      expect(album.all_permitted_members).to include("Greg")
      expect(album.all_permitted_members).to_not include("Mike")
      expect(@carol.can_see?(album)).to eq(false)
    end

    it "for parents" do
      album.permissions = "2"
      expect(@carol.can_see?(album)).to eq(true)
      expect(album.relationships_permitted).to include("mother", "father")
      expect(album.all_permitted_members).to include("Mike")
      expect(album.all_permitted_members).to_not include("Greg")
      expect(@connie.can_see?(album)).to eq(false)
    end

    it "for children" do
      album2.permissions = "3"
      expect(@marcia.can_see?(album2)).to eq(true)
      expect(album2.relationships_permitted).to include("son", "daughter")
      expect(album2.all_permitted_members).to include("Greg")
      expect(album2.all_permitted_members).to_not include("Harold")
      expect(@mike.can_see?(album2)).to eq(false)

    end

    it "for grandparents" do
      album.permissions = "4"
      expect(@harold.can_see?(album2)).to eq(true)
      expect(album.relationships_permitted).to include("grandmother", "grandfather")
      expect(album.all_permitted_members).to include("Connie")
      expect(album.all_permitted_members).to_not include("Mike")
      expect(@greg.can_see?(album)).to eq(false)

    end

    it "for grandchildren" do
      album3.permissions = "5"
      expect(@marcia.can_see?(album3)).to eq(true)
      expect(album3.relationships_permitted).to include("grandson", "granddaughter")
      expect(album3.all_permitted_members).to include("Greg")
      expect(album3.all_permitted_members).to_not include("Carol")
      expect(@connie.can_see?(album3)).to eq(false)

    end

    it "for parents-in-laws" do
      album4.permissions = "7"
      expect(@connie.can_see?(album4)).to eq(true)
      expect(album4.relationships_permitted).to include("father_in_law", "mother_in_law")
      expect(album4.all_permitted_members).to include()
      expect(album4.all_permitted_members).to_not include("Marcia")
      expect(@carol.can_see?(album4)).to eq(false)
    end

    it "for children-in-laws" do
      album3.permissions = "6"
      expect(@mike.can_see?(album3)).to eq(true)
      expect(album3.relationships_permitted).to include("son_in_law", "daughter_in_law")
      expect(album3.all_permitted_members).to_not include("Greg")
      expect(@carol.can_see?(album3)).to eq(false)
    end

    it "for spouse" do
      album2.permissions = "8"
      expect(@mike.can_see?(album2)).to eq(true)
      expect(album2.relationships_permitted).to include("husband", "wife")
      expect(album2.all_permitted_members).to include("Mike")
      expect(album2.all_permitted_members).to_not include("Harold")
      expect(@marcia.can_see?(album2)).to eq(false)
    end

    it "for aunts and uncles" do
      album.permissions = "9"
      expect(@jenny.can_see?(album)).to eq(true)
      expect(album.relationships_permitted).to include("uncle", "aunt")
      expect(album.all_permitted_members).to include("Jon")
      expect(album.all_permitted_members).to_not include("Mike")
      expect(@harold.can_see?(album)).to eq(false)
    end

    it "for nieces and nephews" do
      album2.permissions = "10"
      expect(@jon_jr.can_see?(album2)).to eq(true)
      expect(album2.relationships_permitted).to include("niece", "nephew")
      expect(album2.all_permitted_members).to include("Jon Jr.")
      expect(album2.all_permitted_members).to_not include("Connie")
      expect(@marcia.can_see?(album2)).to eq(false)
    end

    it "for cousins" do
      album.permissions = "11"
      expect(@jon_jr.can_see?(album)).to eq(true)
      expect(album.relationships_permitted).to include("cousin")
      expect(album.all_permitted_members).to include("Jon Jr.")
      expect(album.all_permitted_members).to_not include("Carol")
      expect(@greg.can_see?(album)).to eq(false)
    end

    it "for siblings_in_law" do
      album4.permissions = "12"
      expect(@jenny.can_see?(album4)).to eq(true)
      expect(album4.relationships_permitted).to include("brother_in_law", "sister_in_law")
      expect(album4.all_permitted_members).to include("Jenny")
      expect(album4.all_permitted_members).to_not include("Carol")
      expect(@greg.can_see?(album4)).to eq(false)
    end
  end

  describe "for individual checkboxes" do
    it "with one person excluded" do
      album.permissions = "1 2 4 11 jon5"
      expect(@jon.can_see?(album)).to eq(true)
      expect(album.all_permitted_members).to include("Carol")
      expect(album.all_permitted_members).to_not include("Jenny")
      expect(@jenny.can_see?(album4)).to eq(false)
    end

    it "with one person included" do
      album.permissions = "connie1"
      expect(@connie.can_see?(album)).to eq(true)
      expect(album.relationships_permitted).to be_blank
      expect(@jenny.can_see?(album)).to eq(false)
    end
  end
end