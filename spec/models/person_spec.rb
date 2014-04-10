require 'spec_helper'

describe Person do
  before :each do
    @brady = create(:family)
    @connie = create(:person, last_name: "Hutchins", gender: "F")
    @harold = create(:person, gender: "M")
    @carol = create(:person, mother_id: @connie.id, father_id: @harold.id, gender: "F")
    @mike = create(:person, gender: "M")
    @greg = create(:person, mother_id: @carol.id, father_id: @mike.id, gender: "M")
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
      expect(grandaughter.grandmothers[:maternal]).to eq(maternal_grandmother)
    end

    it "can assign a maternal grandfather" do
      grandaughter.maternal_grandfather = maternal_grandfather
      expect(grandaughter.grandfathers[:maternal]).to eq(maternal_grandfather)
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
      expect(grandaughter.grandmothers[:paternal]).to eq(paternal_grandmother)
    end

    it "can assign a paternal grandfather" do
      grandaughter.paternal_grandfather = paternal_grandfather
      expect(grandaughter.grandfathers[:paternal]).to eq(paternal_grandfather)
    end
  end

  # xit "cannot create families" do
  # end

  # context "as admin" do
  #   it "can create families" do
  #   end
  # end
end
