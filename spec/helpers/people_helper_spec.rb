require 'spec_helper'

describe PeopleHelper do
  describe "rearranging a new family array" do
    let(:mother)      {create(:person)}
    let(:father)      {create(:person)}
    let(:son)         {create(:person)}
    let(:daughter)    {create(:person)}
    let(:grandmother) {create(:person)}
    let(:members) {[[grandmother, "grandmother"], [son, "son"], [daughter, "daughter"], [father, "father"], [mother, "mother"]]}

  before(:each) do
    @rearranged_array = helper.rearrange_members(members)
  end

    it "puts grandparents at the end of the inputted array" do
      expect(@rearranged_array.last).to eq([grandmother, "grandmother"])
    end

    it "puts mother toward the front" do
      mother_index = @rearranged_array.index([mother, "mother"])
      expect(0..1).to cover(mother_index)
    end

    it "puts father toward the front" do
      father_index = @rearranged_array.index([father, "father"])
      expect(0..1).to cover(father_index)
    end
  end

  describe "setting relations" do
    let(:admin)                {create(:person, gender: "M")} 
    let(:wife)                 {create(:person, gender: "F", first_name: "wife")}
    let(:son)                  {create(:person, gender: "M", first_name: "son")}
    let(:daughter)             {create(:person, gender: "F", first_name: "daughter")}
    let(:grandmother_maternal) {create(:person, gender: "F", first_name: "grandmother_maternal")}
    let(:brother) {create(:person, gender: "M", first_name: "brother")}
    let(:mother) {create(:person, gender: "F", first_name: "mother")}
    let(:members) {[[wife, "wife"], [son, "son"], [daughter, "daughter"], [brother, "brother"], [mother, "mother"], [grandmother_maternal, "grandmother (maternal)"]]}

    before(:each) do
      helper.set_relations(helper.rearrange_members(members), admin) 
    end

    it 'assigns a mother to admin' do
      expect(admin.mother).to eq(mother)
    end

    it 'assigns the admin as the son' do
      expect(mother.sons).to include(admin)
    end

    it 'assigns a spouse to admin' do
      expect(admin.spouse).to eq(wife)
    end

    it 'assigns children to admin' do
      expect(admin.children).to include(son)
      expect(admin.children).to include(daughter)
    end

    it 'gives the admin children' do
      expect(son.father).to eq(admin)
      expect(daughter.father).to eq(admin)
    end

    it 'assigns grandparents to admin' do
      expect(admin.grandparents).to include(grandmother_maternal)
    end

    it 'assigns a sibling to admin' do
      expect(admin.siblings).to include(brother)
    end

    # it 'expects proper save of wife' do
    #   expect(wife).to eq(son.mother)
    # end

    it 'assigns admin as a father' do
      expect(son.father).to eq(admin)
      expect(daughter.father).to eq(admin)
    end

    it 'assigns admin\'s wife as mother' do
      expect(admin.children.first.mother).to eq(wife)
      expect(admin.children.second.mother).to eq(wife)
    end

    it 'assigns admin\'s mother as grandmother' do
      expect(admin.children.first.grandmothers).to include(admin.mother)
    end

    it 'assigns admin\'s wife as daughter-in-law' do
      expect(admin.wife.relationship_to(admin.mother)).to eq("daughter_in_law")
    end
  end
end
