require_relative '../feature_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Album" do
  before :each do
    @person = create(:person)
    @person.confirmed_at = Time.now
    @person.save
    @family = create(:family, name: "brady")
    @family.person_families.create(person: @person)

    @album = create(:album)
    @album2 = create(:album)
    @family.albums << @album
    @family.albums << @album2
    @person.albums << @album
    @person.albums << @album2
    login_as(@person, :scope => :person)
  end

  after :each do
    Warden.test_reset!
  end

  scenario "album index displays all albums" do
    visit 'families/1/albums'
    expect(page).to have_content(@album.name)
    expect(page).to have_content(@album2.name)
  end

  scenario "album index displays when no albums exist" do  
    Album.all.delete_all
    visit 'families/brady/albums'
    expect(page).to have_content("You have 0 albums.")
  end

  scenario "shows 0 albums in index with ajax if all deleted" do
    visit 'families/brady/albums'
    find("div[data-id='1']").find("a.delete_x").click
    find("div[data-id='2']").find("a.delete_x").click
    expect(Album.all.length).to eq(0)
    expect(page).to have_content("You have 0 albums.")
  end

  scenario "can view album from index" do
    visit 'families/brady/albums'
    find("div[data-id='1']").first(:xpath, "//a[@href='/families/brady/albums/1']").click
    expect(page).to have_content("Add a Photo")
  end

  scenario "can create album from index" do
    visit 'families/brady/albums'
    click_link "Create an album!"
    expect(page).to have_button("Create Album")
  end
end