require 'spec_helper'

describe Family do
  before :each do
    @family = create(:family)
    @album = create(:album)
    @family.albums << @album
  end

  it "has a name" do
    expect(@family.name).not_to be_empty
  end

  it "has many albums" do
    expect(@family.albums).to include(@album)
  end

  it "can add members to itself for testing purposes" do
    @don = create(:person, first_name: "Don")
    @linda = create(:person, first_name: "Linda")
    @dewitte = create(:family, name: "DeWitte")

    @dewitte.add_members([@don, @linda])

    expect(@don.families.first).to eq(@dewitte)
    expect(@linda.families.first).to eq(@dewitte)
  end

  it "deletes all associated members when destroyed" do
    make_brady_bunch
    @brady.destroy

    expect(Person.find_by(first_name: "Marcia")).to eq(nil)
  end
end
