require_relative '../feature_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Checkboxes" do
  before :each do
    make_brady_bunch
    login_as(@greg, :scope => :person)
  end

  after :each do
    Warden.test_reset!
  end

  scenario "about us page displays correctly" do
   visit "families/#{@brady.name_slug}/conversations"
   save_and_open_page
   page.check('1')
   click_link('By Person')
   cindy_checkbox = find('#conversation_parse_permission_cindy7')
   carol_checkbox = find('#conversation_parse_permission_carol3')
   expect(cindy_checkbox.checked?).to eq(true)
   expect(carol_checkbox.checked?).to eq(false)
  end
end