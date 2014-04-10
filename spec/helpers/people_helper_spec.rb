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
    it "puts grandparents at the end of the inputted array" do
      mother = create(:person)
      son = create(:person)
      daughter = create(:person)
      grandmother = create(:person)
      members = [[grandmother, "grandmother"], [mother, "mother"], [son, "son"], [daughter, "daughter"]]
      
      rearranged_array = helper.rearrange_grandparents(members)

      expect(rearranged_array.last).to eq([grandmother, "grandmother"])
    end
  end

  describe "setting relations" do
    let(:admin) {create(:person, gender: "M")} 
    let(:wife) {create(:person, gender: "F")}
    let(:son) {create(:person, gender: "M")}
    let(:daughter) {create(:person, gender: "F")}
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

    it 'assigns admin as a father' do
      expect(son.father).to eq(admin)
      expect(daughter.father).to eq(admin)
    end

    it 'assigns admin\'s wife as mother' do
      expect(son.mother).to eq(wife)
      expect(daughter.mother).to eq(wife)
    end

    xit 'assigns admin\'s mother as grandmother' do
    end

    xit 'assigns admin\'s children as grandchildren' do
    end

    xit 'assigns admin\'s wife as daughter-in-law' do
    end
  end
end
