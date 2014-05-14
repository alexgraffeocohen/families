require 'spec_helper'
include Relationable
include Findable
include Extendable

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

  it "can determine paternal grandfather" do
    expect(@robert.relationship_to(@greg)).to eq('paternal-grandfather')
  end

  it "can determine maternal grandfather" do
    expect(@harold.relationship_to(@greg)).to eq('maternal-grandfather')
  end

  it "can determine maternal grandmother" do
    expect(@connie.relationship_to(@marcia)).to eq('maternal-grandmother')
  end

  it "can determine paternal grandmother" do
    expect(@rachel.relationship_to(@greg)).to eq('paternal-grandmother')
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

  it "can determine maternal aunt" do
    expect(@jenny.relationship_to(@greg)).to eq('maternal-aunt')
  end

  it "can determine paternal aunt" do
    expect(@rebekah.relationship_to(@marcia)).to eq('paternal-aunt')
  end

  it "can determine maternal uncle" do
    expect(@jon.relationship_to(@marcia)).to eq('maternal-uncle')
  end

  it "can determine paternal uncle" do
    expect(@dan.relationship_to(@marcia)).to eq('paternal-uncle')
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
    expect(@carol.relationship_to(@rachel)).to eq('daughter-in-law')
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
      greg_daughter = create(:person, gender: "F")
      greg_daughter.father = @greg
      greg_daughter.save
      binding.pry
      
      expect(greg_daughter.great_uncles).to include(@jon, @dan)
    end

    it "can have great aunts" do
      marcia_son = create(:person, gender: "M")
      marcia_son.mother = @marcia
      marcia_son.save
     
      expect(marcia_son.great_aunts).to include(@rebekah, @jenny)
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

    it "has paternal great-grandfathers" do
      lysander = create(:person, gender: "M", first_name: "Lysander")
      @robert.father = lysander
      @robert.save
      
      expect(@greg.paternal_great_grandfathers).to include(lysander)
    end

    it "has maternal great-grandfathers" do
      jobe = create(:person, gender: "M", first_name: "Jobe")
      @harold.father = jobe
      @harold.save
      
      expect(@greg.maternal_great_grandfathers).to include(jobe)
    end
  end
end