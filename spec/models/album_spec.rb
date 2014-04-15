require 'spec_helper'

describe Album do
  let(:mother) {create :person, gender: "F"}
  let(:daughter) {create :person, mother_id: mother.id, gender: "F"}
  let(:son) {create :person, mother_id: mother.id, gender: "M"}
  let(:album) {create(:album, person_id: daughter.id)}

  it "has photos" do
    photo = create(:photo)
    album.photos << photo
    expect(album.photos).to include photo
  end

  it "belongs to a family" do
    family = create(:family)
    family.albums << album
    expect(album.family).to eq family
  end

  context "supports single permissions" do
    let(:album2){create(:album, person_id: daughter.id, permissions: "1")}
    it "can block people" do
      expect(album2.relationships_permitted).to_not include("mother")
      expect(mother.can_see?(album2)).to eq(false)
    end

    it "can allow people" do
      expect(album2.relationships_permitted).to include("brother")
      expect(son.can_see?(album2)).to eq(true)
    end

    it "including self" do
      expect(daughter.can_see?(album2)).to eq(true)
    end
  end

  context "supports multiple permissions" do
    let(:album3){create(:album, person_id: daughter.id, permissions: "1 2")}
    it "can block people" do
      expect(album.relationships_permitted).to include("mother")
      expect(mother.can_see?(album3)).to eq(true)
    end

    it "can allow people" do
      expect(album.relationships_permitted).to include("brother")
      expect(son.can_see?(album3)).to eq(true)
    end
  end
end
