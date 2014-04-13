require_relative '../feature_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Conversation" do
  before :each do
    @family = create(:family)
    @conversation = create(:conversation)
    @family.albums << @album
    @family.albums << @album2
    @person.albums << @album
    @person.albums << @album2
    login_as(@person, :scope => :person)
  end

  after :each do
    Warden.test_reset!
  end

  scenario "index displays all" do
    save_and_open_page
    visit 'families/1/conversation'
    expect(page).to have_content(@album1.name)
    expect(page).to have_content(@album2.name)
  end
end