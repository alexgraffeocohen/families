require_relative '../feature_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Photo" do
  before :each do
    @family = create(:family, name: "brady")
    @grandma = create(:person, gender: "F")
    @grandma.confirmed_at = Time.now
    @grandma.save
    @mom = create(:person, gender: "F", mother_id: @grandma.id)
    @dad = create(:person, gender: "M", spouse_id: @mom.id)
    @grandson = create(:person, gender: "M", mother_id: @mom.id, father_id: @dad.id)
    @grandson.confirmed_at = Time.now
    @grandson.save
    @granddaughter = create(:person, gender: "F", mother_id: @mom.id, father_id: @dad.id)

    @family.person_families.create(person: @grandma)
    @family.person_families.create(person: @grandson)

    login_as(@grandson, :scope => :person)
  end

  after :each do
    Warden.test_reset!
  end

  scenario "about us page displays correctly" do
   visit 'families/brady/about_us'
   expect(page).to have_content("#{@grandma.first_name}, your grandmother")
  end
end