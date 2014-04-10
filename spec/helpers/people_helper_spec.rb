require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the PeopleHelper. For example:
#
# describe PeopleHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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
    let(:wife)                 {create(:person, gender: "F")}
    let(:son)                  {create(:person, gender: "M")}
    let(:daughter)             {create(:person, gender: "F")}
    let(:grandmother_maternal) {create(:person, gender: "F")}
    let(:brother) {create(:person, gender: "M")}
    let(:mother) {create(:person, gender: "F")}
    let(:members) {[[wife, "wife"], [son, "son"], [daughter, "daughter"], [brother, "brother"], [mother, "mother"], [grandmother_maternal, "grandmother (maternal)"]]}

    before(:each) do
      helper.set_relations(members, admin) 
    end

    it 'assigns a mother to admin' do
      expect(admin.mother).to eq(mother)
    end

    it 'assigns a spouse to admin' do
      expect(admin.spouse_id).to eq(wife.id)
    end

    it 'assigns children to admin' do
      expect(admin.children).to include(son)
      expect(admin.children).to include(daughter)
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
      expect(admin.children.first.grandmother).to eq(admin.mother)
    end

    it 'assigns admin\'s children as grandchildren' do
      expect(admin.mother).to eq(admin.children.second.grandmother)
    end

    it 'assigns admin\'s wife as daughter-in-law' do
      expect(admin.wife).to eq(admin.mother.daughter_in_law)
    end
  end
end
