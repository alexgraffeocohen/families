require_relative '../feature_helper'
require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Checkboxes as Greg" do
  before :each do
    make_brady_bunch
    login_as(@greg, :scope => :person)
  end

  after :each do
    Warden.test_reset!
  end

  scenario "sibling checkbox", js: true do
    puts @brady.name_slug
     visit "/"
     find_link("Our Conversations").trigger('click')
     page.check('conversation_parse_permission_1')
     sleep 3
     expect(find('#conversation_parse_permission_1').checked?).to eq(true)
     expect(find("input#conversation_parse_permission_#{@cindy.permission_slug}").checked?).to eq(true)
     # expect(find("#conversation_parse_permission_#{@carol.permission_slug}").checked?).to eq(false)
  end

  xscenario "parent checkbox", js: true do
     visit "families/#{@brady.name_slug}/conversations"
     page.check('conversation_parse_permission_2')
     click_link('By Person')
     page.has_checked_field?('conversation_parse_permission_mike#{@mike.id}')
     page.has_unchecked_field?('conversation_parse_permission_peter#{@peter.id}')
  end

  xscenario "grandparent checkbox", js: true do
     visit "families/#{@brady.name_slug}/conversations"
     page.check('conversation_parse_permission_4')
     click_link('By Person')
     page.has_checked_field?('conversation_parse_permission_connie#{@connie.id}')
     page.has_unchecked_field?('conversation_parse_permission_jenny#{@jenny.id}')
  end

  xscenario "aunts/uncles checkbox", js: true do
     visit "families/#{@brady.name_slug}/conversations"
     page.check('conversation_parse_permission_9')
     click_link('By Person')
     page.has_checked_field?('conversation_parse_permission_jon#{@jon.id}')
     page.has_unchecked_field?('conversation_parse_permission_marcia#{@marcia.id}')
  end
end

feature "Checkboxes as Connie" do
  before :each do
    make_brady_bunch
    login_as(@connie, :scope => :person)
  end

  after :each do
    Warden.test_reset!
  end

  xscenario "grandchild checkbox", js: true do
     visit "families/#{@brady.name_slug}/conversations"
     page.check('conversation_parse_permission_5')
     click_link('By Person')
     page.has_checked_field?('conversation_parse_permission_mike#{@mike.id}')
     page.has_unchecked_field?('conversation_parse_permission_peter#{@peter.id}')
  end

  xscenario "children checkbox", js: true do
     visit "families/#{@brady.name_slug}/conversations"
     page.check('conversation_parse_permission_3')
     click_link('By Person')
     page.has_checked_field?('conversation_parse_permission_connie#{@connie.id}')
     page.has_unchecked_field?('conversation_parse_permission_jenny#{@jenny.id}')
  end

  xscenario "children-in-law checkbox", js: true do
     visit "families/#{@brady.name_slug}/conversations"
     page.check('conversation_parse_permission_6')
     click_link('By Person')
     page.has_checked_field?('conversation_parse_permission_jon#{@jon.id}')
     page.has_unchecked_field?('conversation_parse_permission_marcia#{@marcia.id}')
  end
end