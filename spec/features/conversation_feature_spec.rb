require_relative '../feature_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Conversation" do
  before :each do
    make_brady_bunch
    @conversation = build(:conversation, family: @brady)
    @conversation.owner = @greg
    @conversation.permissions = "1"
    @conversation.save(:validate => false)
    
    login_as(@greg, :scope => :person)
  end

  after :each do
    Warden.test_reset!
  end

  scenario "index displays all" do
    visit "families/#{@brady.name_slug}/conversations"
    expect(page).to have_content(@conversation.title)
  end

  xscenario "fill in title", js: true do
    visit conversations_path(@brady)
    save_and_open_page
    fill_in "Title", with: "Vacation Talk"
    click_button "Create Conversation"
    page.should have_content("Create a Conversation")
  end

end