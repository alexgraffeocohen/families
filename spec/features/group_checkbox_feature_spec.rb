require_relative '../feature_helper'
require 'spec_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Group checkboxes as Greg" do
  before :each do
    make_brady_bunch
    login_as(@greg, :scope => :person)
    visit "/families/#{@brady.name_slug}/conversations"
    binding.pry
    find_link("By Person").trigger('click')
  end

  after :each do
    Warden.test_reset!
  end

  scenario "sibling checkbox", js: true do
     # visit "/"
     # find_link("Our Conversations").trigger('click')
    page.check('conversation_parse_permission_1')
    expect(find('#conversation_parse_permission_4').checked?).to eq(false)
    expect(find("#conversation_parse_permission_#{@cindy.permission_slug}").checked?).to eq(true)
    expect(find("#conversation_parse_permission_#{@carol.permission_slug}").checked?).to eq(false)
  end

  scenario "parent checkbox", js: true do
    page.check('conversation_parse_permission_2')
    expect(find('#conversation_parse_permission_9').checked?).to eq(false)
    expect(find("#conversation_parse_permission_#{@mike.permission_slug}").checked?).to eq(true)
    expect(find("#conversation_parse_permission_#{@marcia.permission_slug}").checked?).to eq(false)
  end

  scenario "grandparent checkbox", js: true do
    page.check('conversation_parse_permission_4')
    expect(find('#conversation_parse_permission_1').checked?).to eq(false)
    expect(find("#conversation_parse_permission_#{@connie.permission_slug}").checked?).to eq(true)
    expect(find("#conversation_parse_permission_#{@jon.permission_slug}").checked?).to eq(false)
  end

  scenario "aunts/uncles checkbox", js: true do
    page.check('conversation_parse_permission_9')
    expect(find('#conversation_parse_permission_2').checked?).to eq(false)
    expect(find("#conversation_parse_permission_#{@jenny.permission_slug}").checked?).to eq(true)
    expect(find("#conversation_parse_permission_#{@bobby.permission_slug}").checked?).to eq(false)
  end
end

feature "Group checkboxes as Connie" do
  before :each do
    make_brady_bunch
    login_as(@connie, :scope => :person)
    visit "/families/#{@brady.name_slug}/conversations"
    find_link("By Person").trigger('click')
  end

  after :each do
    Warden.test_reset!
  end

  scenario "grandchild checkbox", js: true do
    page.check('conversation_parse_permission_5')
    expect(find('#conversation_parse_permission_3').checked?).to eq(false)
    expect(find("#conversation_parse_permission_#{@marcia.permission_slug}").checked?).to eq(true)
    expect(find("#conversation_parse_permission_#{@mike.permission_slug}").checked?).to eq(false)
  end

  scenario "children checkbox", js: true do
    page.check('conversation_parse_permission_3')
    expect(find('#conversation_parse_permission_5').checked?).to eq(false)
    expect(find("#conversation_parse_permission_#{@carol.permission_slug}").checked?).to eq(true)
    expect(find("#conversation_parse_permission_#{@jan.permission_slug}").checked?).to eq(false)
  end

  scenario "children-in-law checkbox", js: true do
    page.check('conversation_parse_permission_6')
    expect(find('#conversation_parse_permission_3').checked?).to eq(false)
    expect(find("#conversation_parse_permission_#{@mike.permission_slug}").checked?).to eq(true)
    expect(find("#conversation_parse_permission_#{@carol.permission_slug}").checked?).to eq(false)
  end
end

feature "Group checkboxes as Mike" do
  before :each do
    make_brady_bunch
    login_as(@mike, :scope => :person)
    visit "/families/#{@brady.name_slug}/conversations"
    find_link("By Person").trigger('click')
  end

  after :each do
    Warden.test_reset!
  end

  scenario "sibling in laws checkbox", js: true do
    page.check('conversation_parse_permission_12')
    expect(find('#conversation_parse_permission_8').checked?).to eq(false)
    expect(find("#conversation_parse_permission_#{@jon.permission_slug}").checked?).to eq(true)
    expect(find("#conversation_parse_permission_#{@carol.permission_slug}").checked?).to eq(false)
  end

  scenario "parent in laws checkbox", js: true do
    page.check('conversation_parse_permission_7')
    expect(find('#conversation_parse_permission_3').checked?).to eq(false)
    expect(find("#conversation_parse_permission_#{@harold.permission_slug}").checked?).to eq(true)
    expect(find("#conversation_parse_permission_#{@jenny.permission_slug}").checked?).to eq(false)
  end
end