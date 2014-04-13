require_relative '../feature_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Conversation" do
  before :each do
    @family = create(:family, name: "brady")
    @person = create(:person, confirmed_at: Time.now)
    @family.person_families.create(person: @person)
    @conversation = create(:conversation, family_id: @family.id)
    login_as(@person, :scope => :person)
  end

  after :each do
    Warden.test_reset!
  end

  scenario "index displays all" do
    visit 'families/brady/conversations'
    expect(page).to have_content(@conversation.title)
  end
end