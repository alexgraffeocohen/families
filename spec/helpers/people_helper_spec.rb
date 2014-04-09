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
  describe "setting relations" do
    it "assigns relations correctly given family members" do
      admin = create(:person)
      wife = create(:person)
      son = create(:person)
      daughter = create(:person)

      members = [[wife, "wife"], [son, "son"], [daughter, "daughter"]]

      helper.set_relations(members, admin)
    end
end
