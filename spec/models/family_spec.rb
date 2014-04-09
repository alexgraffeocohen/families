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
end
