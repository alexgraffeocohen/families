require 'spec_helper'

describe Person do
  before :each do
    @brady = create(:family)
    @connie = create(:person, last_name: "Hutchins")
    @harold = create(:person)
    @carol = create(:person, mother_id: @connie.id, father_id: @harold.id)
    @mike = create(:person)
    @greg = create(:person, mother_id: @carol.id, father_id: @mike.id, gender: "M")
    @marcia = create(:person, mother_id: @carol.id, father_id: @mike.id, gender: "F")
    @connie.spouse = @harold
    @harold.spouse = @connie
    @carol.spouse = @mike
    @mike.spouse = @carol
    @brady.add_members([@harold, @carol, @mike, @greg, @marcia])
  end
  
  it "has mother" do
    expect(@marcia.mother).to eq(@carol)
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

  it "can belong to a family" do 
    expect(@mike.default_family).to eq(@brady)
  end 

  it "has maternal grandmother" do 
    expect(@greg.grandmothers[:maternal]).to eq(@connie)
  end 

  it "has maternal grandfather" do 
    expect(@greg.grandfathers[:maternal]).to eq(@harold)
  end 

  it "gets a last name by default" do
    expect(@carol.last_name).to eq(@brady.name)
  end

  it "can have a separate last name" do
    expect(@connie.last_name).to eq("Hutchins")
  end

  # xit "cannot create families" do
  # end

  # context "as admin" do
  #   it "can create families" do
  #   end
  # end
end
