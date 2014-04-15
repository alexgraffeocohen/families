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

  describe "when spouse exists" do
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

  describe "relationable can tell if a person" do
    before :each do
      @brady = create(:family)
      @connie = create(:person, last_name: "Hutchins", gender: "F")
      @harold = create(:person, gender: "M")
      @carol = create(:person, mother_id: @connie.id, father_id: @harold.id, gender: "F")
      @mike = create(:person, gender: "M")
      @greg = create(:person, mother_id: @carol.id, father_id: @mike.id, gender: "M", email: "greg@greg.com")
      @marcia = create(:person, mother_id: @carol.id, father_id: @mike.id, gender: "F")
      @connie.add_spouse(@harold)
      @carol.add_spouse(@mike)
      @brady.add_members([@harold, @carol, @mike, @greg, @marcia])
    end
    
    it "has mother" do
      expect(@marcia.mother).to eq(@carol)
    end

    it "can have a wife" do
      expect(@harold.wife).to eq(@connie)
    end

    it "can have a husband" do
      expect(@carol.husband).to eq(@mike)
    end

    it "can have sons" do
      expect(@carol.sons).to include(@greg)
    end

    it "can have daughters" do
      expect(@carol.daughters).to include(@marcia)
    end

    it "has father" do 
      expect(@greg.father).to eq(@mike)
    end

    it "has brothers" do
      expect(@marcia.brothers).to include(@greg)
    end

    it "has sisters" do 
      expect(@greg.sisters).to include(@marcia)
    end

    it "can have aunts" do
      aunt = create(:person, gender: "F")
      aunt.mother = @carol.mother
      aunt.save

      expect(@greg.aunts).to include(aunt)
    end

    it "can have uncles" do
      uncle = create(:person, gender: "M")
      uncle.father = @carol.father
      uncle.save

      expect(@greg.uncles).to include(uncle)
    end

    it "can have great uncles" do
      great_uncle = create(:person, gender: "M")
      father = create(:person, gender: "M")
      @mike.father, great_uncle.father = father, father
      @mike.save
      great_uncle.save

      greg_daughter = create(:person, gender: "F")
      greg_daughter.father = @greg
      greg_daughter.save

      expect(greg_daughter.great_uncles).to include(great_uncle)
    end

    it "can have great aunts" do
      great_aunt = create(:person, gender: "F")
      mother = create(:person, gender: "F")
      @carol.mother, great_aunt.mother = mother, mother
      @carol.save
      great_aunt.save

      marcia_son = create(:person, gender: "M")
      marcia_son.mother = @marcia
      marcia_son.save

      expect(marcia_son.great_aunts).to include(great_aunt)
    end

    it "can have nephews" do
      marcia_son = create(:person, gender: "M")
      marcia_son.mother = @marcia
      marcia_son.save

      expect(@greg.nephews).to include(marcia_son)
    end

    it "can have nieces" do
      greg_daughter = create(:person, gender: "F")
      greg_daughter.father = @greg
      greg_daughter.save

      expect(@marcia.nieces).to include(greg_daughter)
    end

    it "can have cousins" do
      marcia_son = create(:person, gender: "M")
      marcia_son.mother = @marcia
      marcia_son.save

      greg_daughter = create(:person, gender: "F")
      greg_daughter.father = @greg
      greg_daughter.save

      expect(greg_daughter.cousins).to include(marcia_son)
    end

    it "can have brothers_in_law" do
      marcia_husband = create(:person, gender: "M")
      @marcia.add_spouse(marcia_husband)

      expect(marcia_husband.brothers_in_law).to include(@greg)
    end

    it "can have sisters_in_law" do
      greg_wife = create(:person, gender: "F")
      @greg.add_spouse(greg_wife)

      expect(greg_wife.sisters_in_law).to include(@marcia)
    end  

    it "has maternal grandmother" do 
      expect(@greg.grandmothers).to include(@connie)
    end 

    it "has maternal grandfather" do 
      expect(@greg.grandfathers).to include(@harold)
    end 
  end

  describe 'assigning maternal grandparents' do
    let(:maternal_grandmother) {create(:person)}
    let(:maternal_grandfather) {create(:person)}
    let(:mother) {create(:person)}
    let(:grandaughter) {create(:person)}

    before(:each) do
      grandaughter.mother = mother
    end
      
    it "can assign a maternal grandmother" do
      grandaughter.maternal_grandmother = maternal_grandmother
      expect(grandaughter.grandmothers).to include(maternal_grandmother)
    end

    it "can assign a maternal grandfather" do
      grandaughter.maternal_grandfather = maternal_grandfather
      expect(grandaughter.grandfathers).to include(maternal_grandfather)
    end
  end

  describe 'assigning paternal grandparents' do
    let(:paternal_grandmother) {create(:person)}
    let(:paternal_grandfather) {create(:person)}
    let(:father) {create(:person)}
    let(:grandaughter) {create(:person)}

    before(:each) do
      grandaughter.father = father
    end
      
    it "can assign a paternal grandmother" do
      grandaughter.paternal_grandmother = paternal_grandmother
      expect(grandaughter.grandmothers).to include(paternal_grandmother)
    end

    it "can assign a paternal grandfather" do
      grandaughter.paternal_grandfather = paternal_grandfather
      expect(grandaughter.grandfathers).to include(paternal_grandfather)
    end
  end

end