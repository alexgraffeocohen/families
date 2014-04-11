require 'spec_helper'
include Relationable

describe Relationable do
  it "can determine son" do
    mom = create(:person, gender: "F")
    son = create(:person, mother_id: mom.id, gender: "M")
    expect(son.relationship_to(mom)).to eq('son')
  end

  it "can determine daughter" do
    mom = create(:person, gender: "F")
    daughter = create(:person, mother_id: mom.id, gender: "F")
    expect(daughter.relationship_to(mom)).to eq('daughter')
  end

  it "can determine sister" do
    mom = create(:person)
    brother = create(:person, mother_id: mom.id, gender: "M")
    sister = create(:person, mother_id: mom.id, gender: "F")
    expect(sister.relationship_to(brother)).to eq('sister')
  end

  it "can determine brother" do
    mom = create(:person)
    brother = create(:person, mother_id: mom.id, gender: "M")
    sister = create(:person, mother_id: mom.id, gender: "F")
    expect(brother.relationship_to(sister)).to eq('brother')
  end
  
  it "can determine grandson" do
    grandma = create(:person, gender: "F")
    mom = create(:person, gender: "F", mother_id: grandma.id)
    grandson = create(:person, gender: "M", mother_id: mom.id)
    expect(grandson.relationship_to(grandma)).to eq('grandson')
  end

  it "can determine granddaughter" do
    grandma = create(:person, gender: "F")
    mom = create(:person, gender: "F", mother_id: grandma.id)
    granddaughter = create(:person, gender: "F", mother_id: mom.id)
    expect(granddaughter.relationship_to(grandma)).to eq('granddaughter')
  end

  it "can determine mother" do
    mom = create(:person, gender: "F")
    daughter = create(:person, mother_id: mom.id, gender: "F")
    expect(mom.relationship_to(daughter)).to eq('mother')
  end

  it "can determine father" do
    dad = create(:person, gender: "M")
    daughter = create(:person, father_id: dad.id, gender: "F")
    expect(dad.relationship_to(daughter)).to eq('father')
  end

  it "can determine grandfather" do
    grandpa = create(:person, gender: "M")
    mom = create(:person, gender: "F", father_id: grandpa.id)
    grandson = create(:person, gender: "M", mother_id: mom.id)
    expect(grandpa.relationship_to(grandson)).to eq('grandfather')
  end

  it "can determine grandmother" do
    grandma = create(:person, gender: "F")
    mom = create(:person, gender: "F", mother_id: grandma.id)
    grandson = create(:person, gender: "M", mother_id: mom.id)
    expect(grandma.relationship_to(grandson)).to eq('grandmother')
  end

  context "when spouse exists" do
    before :each do
      @wife = create(:person, gender: "F")
      @husband = create(:person, spouse_id: @wife.id, gender: "M")
      @wife.spouse_id = @husband.id
      @wife.save 
    end

    it "can determine wife" do
      expect(@wife.relationship_to(@husband)).to eq('wife')
    end

    it "can determine husband" do
      expect(@husband.relationship_to(@wife)).to eq('husband')
    end

    it "can determine son-in-law" do
      wifes_mother = create(:person)
      @wife.mother_id = wifes_mother.id
      @wife.save
      expect(@husband.relationship_to(wifes_mother)).to eq('son_in_law')
    end

    it "can determine daughter-in-law" do
      husbands_mother = create(:person)
      @husband.mother_id = husbands_mother.id
      @husband.save
      expect(@wife.relationship_to(husbands_mother)).to eq('daughter_in_law')
    end
  end
end