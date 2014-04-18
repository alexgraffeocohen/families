require 'spec_helper'

describe PeopleHelper do
  let(:admin)                {create(:person, gender: "M", first_name: "admin")} 
  let(:wife)                 {create(:person, first_name: "wife")}
  let(:son)                  {create(:person, first_name: "son")}
  let(:daughter)             {create(:person, first_name: "daughter")}
  let(:maternal_grandmother) {create(:person, first_name: "maternal_grandmother")}
  let(:brother) {create(:person, first_name: "brother")}
  let(:mother) {create(:person, first_name: "mother")}
  let(:father) {create(:person, first_name: "father")}
  let(:maternal_aunt) {create(:person, first_name: "maternal_aunt" )}
  let(:paternal_uncle) {create(:person, first_name: "paternal_uncle" )}
  let(:members) {[[maternal_grandmother, "maternal grandmother"], [son, "son"], [daughter, "daughter"], [maternal_aunt, "maternal aunt"], [paternal_uncle, "paternal uncle"], [wife, "wife"], [brother, "brother"], [father, "father"], [mother, "mother"]]}
  
  describe "rearranging a new family array" do
    before(:each) do
      @rearranged_array = helper.rearrange_members(members)
    end

    it "puts grandparents toward the end of the inputted array" do
      expect(@rearranged_array.last(3)[0]).to eq([maternal_grandmother, "maternal grandmother"])
    end

    it "puts mother toward the front" do
      expect(@rearranged_array.first(3)).to include([mother, "mother"])
    end

    it "puts father toward the front" do
      expect(@rearranged_array.first(3)).to include([father, "father"])
    end

    it "puts spouse toward the front" do
      expect(@rearranged_array.first(3)).to include([wife, "wife"])
    end

    it "puts uncles toward the end" do
      expect(@rearranged_array.last(3)).to include([paternal_uncle, "paternal uncle"])
    end

    it "puts aunts toward the end" do
      expect(@rearranged_array.last(3)).to include([maternal_aunt, "maternal aunt"])
    end
  end

  describe "setting relations" do
    before(:each) do
      helper.set_relations(helper.rearrange_members(members), admin)
    end

    it 'assigns a mother to admin' do
      expect(admin.mother).to eq(mother)
    end

    it 'assigns the admin as the son' do
      binding.pry
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
      expect(admin.grandparents).to include(maternal_grandmother)
    end

    it 'assigns paternal uncle to admin' do
      expect(admin.uncles).to include(paternal_uncle)
    end

    it 'assigns maternal aunt to admin' do
      expect(admin.aunts).to include(maternal_aunt)
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
      expect(admin.wife.relationship_to(admin.mother)).to eq("daughter-in-law")
    end
  end
end
