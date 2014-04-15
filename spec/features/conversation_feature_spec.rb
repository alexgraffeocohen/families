require_relative '../feature_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Conversation" do
  before :each do
    brady_bunch
    @conversation = build(:conversation, family: @brady)
    @conversation.owner = @greg
    @conversation.permissions = "1"
    @conversation.save(:validate => false)
    
    login_as(@greg, :scope => :person)
  end

  after :each do
    Warden.test_reset!
  end

  scenario "index displays all", js: true do
    visit "families/#{@brady.name_slug}/conversations"
    expect(page).to have_content(@conversation.title)
  end

  scenario "fill in title" do
    visit 'families/brady/conversations'
    fill_in "Title", with: "Vacation Talk"
    click_button "Create Conversation"
    expect(page).to have_content("Create Conversation")
  end

end