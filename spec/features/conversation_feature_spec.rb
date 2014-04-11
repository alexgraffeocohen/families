require_relative '../feature_helper'

# include Warden::Test::Helpers
# Warden.test_mode!

# feature "Conversation" do
#   before :each do
#     @person = create(:person)
#     @person.confirmed_at = Time.now
#     @person.save
#     @family = create(:family)
#     @family.person_families.create(person: @person)

#     @album = create(:album)
#     @album2 = create(:album)
#     @family.albums << @album
#     @family.albums << @album2
#     @person.albums << @album
#     @person.albums << @album2
#     login_as(@person, :scope => :person)
#     # visit '/'
#     # click_link("Log in")

#     # fill_in "Email", with: @person.email
#     # fill_in "Password", with: @person.password
#     # click_button("Sign in")
#   end

#   after :each do
#     Warden.test_reset!
#   end

#   scenario "album index displays all albums" do
#     visit 'families/1/albums'
#     expect(page).to have_content(@album.name)
#     expect(page).to have_content(@album2.name)
#   end
end