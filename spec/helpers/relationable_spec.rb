require 'spec_helper'
include Relationable

describe Relationable do
  before(:each) do
    make_brady_bunch
  end

  it "can determine son" do
    expect(@greg.relationship_to(@carol)).to eq('son')
  end

  it "can determine daughter" do
    expect(@marcia.relationship_to(@carol)).to eq('daughter')
  end

  it "can determine sister" do
    expect(@marcia.relationship_to(@greg)).to eq('sister')
  end

  it "can determine brother" do
    expect(@greg.relationship_to(@marcia)).to eq('brother')
  end
  
  it "can determine grandson" do
    expect(@greg.relationship_to(@harold)).to eq('grandson')
  end

  it "can determine granddaughter" do
    expect(@marcia.relationship_to(@connie)).to eq('granddaughter')
  end

  it "can determine mother" do
    expect(@carol.relationship_to(@greg)).to eq('mother')
  end

  it "can determine father" do
    expect(@mike.relationship_to(@marcia)).to eq('father')
  end

  it "can determine grandfather" do
    expect(@harold.relationship_to(@greg)).to eq('grandfather')
  end

  it "can determine grandmother" do
    expect(@connie.relationship_to(@marcia)).to eq('grandmother')
  end

  it "can determine wife" do
    expect(@carol.relationship_to(@mike)).to eq('wife')
  end

  it "can determine husband" do
    expect(@mike.relationship_to(@carol)).to eq('husband')
  end

  it "can determine son-in-law" do
    expect(@mike.relationship_to(@harold)).to eq('son-in-law')
  end

  it "can determine father-in-law" do
    expect(@harold.relationship_to(@mike)).to eq('father-in-law')
  end

  it "can determine aunt" do
    expect(@jenny.relationship_to(@greg)).to eq('aunt')
  end

  it "can determine uncle" do
    expect(@jon.relationship_to(@greg)).to eq('uncle')
  end

  it "can determine brother-in-law" do
    expect(@mike.relationship_to(@jon)).to eq('brother-in-law')
  end

  it "can determine sister-in-law" do
    expect(@jenny.relationship_to(@mike)).to eq('sister-in-law')
    expect(@carol.relationship_to(@rebekah)).to eq('sister-in-law')
    expect(@rebekah.relationship_to(@carol)).to eq('sister-in-law')
  end

  it "can determine niece" do
    expect(@marcia.relationship_to(@jenny)).to eq('niece')
  end

  it "can determine nephew" do
    expect(@greg.relationship_to(@jon)).to eq('nephew')
  end

  it "can determin cousin" do
    expect(@greg.relationship_to(@jon_jr)).to eq('cousin')
  end

  it "can determine mother-in-law" do
    expect(@connie.relationship_to(@mike)).to eq('mother-in-law')
  end

  it "can determine daughter-in-law" do
    husband = create(:person)
    wife = create(:person, gender: "F")
    husbands_mother = create(:person, gender: "F")
    husband.mother_id = husbands_mother.id
    husband.add_spouse(wife)

    expect(wife.relationship_to(husbands_mother)).to eq('daughter-in-law')
  end

  describe "relationable can tell if a person" do
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
      expect(@greg.aunts).to include(@jenny)
    end

    it "can have uncles" do
      expect(@greg.uncles).to include(@jon)
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
      expect(@jon.nephews).to include(@greg)
    end

    it "can have nieces" do
      expect(@jenny.nieces).to include(@marcia)
    end

    it "can have cousins" do
      expect(@marcia.cousins).to include(@jon_jr)
    end

    it "can have brothers_in_law" do
      expect(@jenny.brother_in_laws).to include(@mike)
    end

    it "can have sisters_in_law" do
      expect(@mike.sister_in_laws).to include(@jenny)
    end

    it "properly detects siblings_in_law" do
      expect(@rebekah.siblings_in_law).to include(@carol)
      expect(@carol.siblings_in_law).to include(@rebekah)
      expect(@mike.siblings_in_law).to include(@jenny)
      expect(@jenny.siblings_in_law).to include(@mike)
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