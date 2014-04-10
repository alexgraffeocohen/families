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
    let(:admin) {create(:person)} 
    let(:wife) {create(:person)}
    let(:son) {create(:person)}
    let(:daughter) {create(:person)}
    let(:grandmother) {create(:person)}
    let(:brother) {create(:person)}
    let(:mother) {create(:person)}
    let(:members) {[[wife, "wife"], [son, "son"], [daughter, "daughter"], [brother, "brother"], [mother, "mother"], [grandmother, "grandmother"]]}

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
      expect(admin.grandparents).to include(grandmother)
    end


      # expect(brother.mother).to eq(admin.mother)
      
    
  end
end
