require_relative '../feature_helper'
require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Individual checkboxes as Greg" do
  before :each do
    make_brady_bunch
    login_as(@greg, :scope => :person)
    visit "/families/#{@brady.name_slug}/conversations"
    find_link("By Person").trigger('click')
  end

  after :each do
    Warden.test_reset!
  end

  scenario "sibling checkbox", js: true do
    page.check('conversation_parse_permission_1')
    page.uncheck("conversation_parse_permission_#{@cindy.permission_slug}")
    sleep 2
    expect(find("#conversation_parse_permission_1").checked?).to eq(false)
    expect(find("#conversation_parse_permission_#{@marcia.permission_slug}").checked?).to eq(true)
  end

  scenario "parent checkbox", js: true do    
    page.check('conversation_parse_permission_2')
    page.uncheck("conversation_parse_permission_#{@carol.permission_slug}")
    sleep 2
    expect(find("#conversation_parse_permission_2").checked?).to eq(false)
    expect(find("#conversation_parse_permission_#{@mike.permission_slug}").checked?).to eq(true)
  end

  scenario "grandparent checkbox", js: true do
    page.check('conversation_parse_permission_4')
    page.uncheck("conversation_parse_permission_#{@connie.permission_slug}")
    sleep 2
    expect(find("#conversation_parse_permission_4").checked?).to eq(false)
    expect(find("#conversation_parse_permission_#{@harold.permission_slug}").checked?).to eq(true)
  end

  scenario "aunts/uncles checkbox", js: true do
    page.check('conversation_parse_permission_9')
    page.uncheck("conversation_parse_permission_#{@jon.permission_slug}")
    sleep 2
    expect(find("#conversation_parse_permission_9").checked?).to eq(false)
    expect(find("#conversation_parse_permission_#{@jenny.permission_slug}").checked?).to eq(true)
  end
end