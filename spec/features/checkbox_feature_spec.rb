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
     page.check('conversation_parse_permission_1')
     click_link('By Person')
     page.has_checked_field?('conversation_parse_permission_cindy#{@cindy.id}')
     page.has_unchecked_field?('conversation_parse_permission_carol#{@carol.id}')
  end

  scenario "about us page displays correctly" do
  end
end