require 'spec_helper'

describe 'Relationable and Extendable' do
  before(:each) do
    make_brady_bunch
  end

  it "can determine mother" do
    expect(@marcia.mother).to eq(@carol)
  end

  it "can determine a wife" do
    expect(@harold.wife).to eq(@connie)
  end

  it "can determine a husband" do
    expect(@carol.husband).to eq(@mike)
  end

  it "can determine sons" do
    expect(@carol.sons).to include(@greg)
  end

  it "can determine daughters" do
    expect(@carol.daughters).to include(@marcia)
  end

  it "can determine father" do 
    expect(@greg.father).to eq(@mike)
  end

  it "can determine brothers" do
    expect(@marcia.brothers).to include(@greg)
  end

  it "can determine sisters" do 
    expect(@greg.sisters).to include(@marcia)
  end

  it "can determine aunts" do
    expect(@greg.aunts).to include(@jenny)
  end

  it "can determine uncles" do
    expect(@greg.uncles).to include(@jon)
  end

  it "can determine great uncles" do
    ally = create(:person, gender: "F", first_name: "Ally")
    ally.father = @greg
    ally.save
    
    expect(ally.great_uncles).to include(@jon, @dan)
  end

  it "can determine great aunts" do
    marcia_son = create(:person, gender: "M")
    marcia_son.mother = @marcia
    marcia_son.save
   
    expect(marcia_son.great_aunts).to include(@rebekah, @jenny)
  end

  it "can determine great-great aunts" do
    alex = create(:person, gender: "M", first_name: "Alex")
    diane = create(:person, gender: "F", first_name: "Diane")
    diane_father = create(:person, gender: "M", first_name: "Diane Father")
    diane_great_aunt = create(:person, gender: "F", first_name: "Diane Great Aunt")
    diane_grandfather = create(:person, gender: "M", first_name: "Diane Grandfather")
    diane_great_grandfather = create(:person, gender: "M", first_name: "Diane Great-Grandfather")
    ophelia = create(:person, gender: "F", first_name: "Ophelia")

    alex.mother = @marcia
    ophelia.father = alex
    ophelia.mother = diane
    diane.father = diane_father
    diane_father.father = diane_grandfather
    diane_grandfather.father = diane_great_grandfather
    diane_great_aunt.father = diane_great_grandfather
    

    diane_grandfather.save
    diane_father.save
    diane_great_aunt.save
    diane.save
    ophelia.save
    alex.save

    expect(ophelia.great_great_aunts).to include(@rebekah, @jenny, diane_great_aunt)
  end

  it "can determine nephews" do
    expect(@jon.nephews).to include(@greg)
  end

  it "can determine nieces" do
    expect(@jenny.nieces).to include(@marcia)
  end

  it "can determine cousins" do
    expect(@marcia.cousins).to include(@jon_jr)
  end

  it "can determine brothers_in_law" do
    expect(@jenny.brother_in_laws).to include(@mike)
  end

  it "can determine sisters_in_law" do
    expect(@mike.sister_in_laws).to include(@jenny)
  end

  it "properly detects siblings_in_law" do
    expect(@rebekah.siblings_in_law).to include(@carol)
    expect(@carol.siblings_in_law).to include(@rebekah)
    expect(@mike.siblings_in_law).to include(@jenny)
    expect(@jenny.siblings_in_law).to include(@mike)
  end

  it "can determine paternal grandfather" do
    expect(@greg.paternal_grandfather).to eq(@robert)
  end

  it "can determine paternal grandmother" do
    expect(@greg.paternal_grandmother).to eq(@rachel)
  end  

  it "can determine maternal grandmother" do 
    expect(@greg.maternal_grandmother).to eq(@connie)
  end 

  it "can determine maternal grandfather" do 
    expect(@greg.maternal_grandfather).to eq(@harold)
  end

  it "can determine paternal great-grandfathers" do
    lysander = create(:person, gender: "M", first_name: "Lysander")
    @robert.father = lysander
    @robert.save
    
    expect(@greg.paternal_great_grandfathers).to include(lysander)
  end

  it "can determine paternal great-great-grandfathers" do
    lysander = create(:person, gender: "M", first_name: "Lysander")
    demetrius = create(:person, gender: "M", first_name: "Demetrius")
    @robert.father = lysander
    lysander.father = demetrius
    lysander.save
    @robert.save

    expect(@greg.paternal_great_great_grandfathers).to include(demetrius)
  end

  it "can determine maternal great-grandfathers" do
    jobe = create(:person, gender: "M", first_name: "Jobe")
    @harold.father = jobe
    @harold.save
    
    expect(@greg.maternal_great_grandfathers).to include(jobe)
  end
end