require_relative '../feature_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Family" do
  before :each do
    make_brady_bunch
    login_as(@greg, :scope => :person)
  end

  after :each do
    Warden.test_reset!
  end

  scenario "about us page displays correctly" do
   visit "families/#{@brady.name_slug}/about_us"
   expect(page).to have_content("Harold, your grandfather")
   expect(page).to have_content("Connie, your grandmother")
   expect(page).to have_content("Carol, your mother")
   expect(page).to have_content("Mike, your father")
   expect(page).to have_content("Marcia, your sister")
  end

  xscenario "it can create a new family" do
    visit 'families/new'
    fill_in "Name", with: "Cosby"
    fill_in "people_emails_", with: "bill@cosby.com"
    click_button "Create Family"
    expect(page).to have_content("Cosby")
  end
end