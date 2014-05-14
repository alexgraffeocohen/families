require 'spec_helper'

describe 'Relationable and Extendable' do
  before(:each) do
    make_brady_bunch
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
    expect(@greg.aunts).to include(@jenny)
  end

  it "can have uncles" do
    expect(@greg.uncles).to include(@jon)
  end

  it "can have great uncles" do
    greg_daughter = create(:person, gender: "F")
    greg_daughter.father = @greg
    greg_daughter.save
    
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