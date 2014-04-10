require 'spec_helper'

describe Album do
  let(:mother) {create :person, gender: "F"}
  let(:daughter) {create :person, mother_id: mother.id, gender: "F"}
  let(:son) {create :person, mother_id: mother.id, gender: "M"}
  let(:album) {create(:album, person_id: daughter.id)}

  it "has photos" do
    photo = create(:photo)
    album.photos << photo
    # binding.pry
    expect(album.photos).to include photo
  end

  it "belongs to a family" do
    family = create(:family)
    family.albums << album
    expect(album.family).to eq family
  end

  context "has permissions" do
    it "can block people" do
      puts album.permissions
      expect(album.relationships_permitted).to_not include("mother")
      expect(mother.can_see_album?(album)).to eq(false)
    end

    it "can allow people" do
      expect(album.relationships_permitted).to include("brother")
      expect(son.can_see_album?(album)).to eq(true)
    end
  end
end
