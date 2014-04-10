require_relative '../feature_helper'

feature "Photo" do
  before :each do
    @family = create(:family)
    @grandma = create(:person, gender: "F")
    @mom = create(:person, gender: "F", mother_id: @grandma.id)
    @dad = create(:person, gender: "M", spouse_id: @mom.id)
    @grandson = create(:person, gender: "M", mother_id: @mom.id, father_id: @dad.id)
    @granddaughter = create(:person, gender: "F", mother_id: @mom.id, father_id: @dad.id)

    visit '/'
    click_link("Log in")
    fill_in "Email", with: @grandson.email
    fill_in "Password", with: @grandson.password
    click_button("Sign in")
  end

  scenario "about us page displays correctly" do
   visit 'families/1/about_us'
   expect(page).to have_content("#{@grandma.first_name}, your grandmother")
  end
end