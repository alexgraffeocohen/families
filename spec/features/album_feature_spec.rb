require_relative '../feature_helper'

include Warden::Test::Helpers
Warden.test_mode!

feature "Album" do
  before :each do
    make_brady_bunch

    @album = create(:album)
    @album2 = create(:album)
    @brady.albums << @album
    @brady.albums << @album2
    @mike.albums << @album2

    login_as(@mike, :scope => :person)
  end

  after :each do
    Warden.test_reset!
  end

  scenario "album index displays all albums current_user can see" do
    visit "families/#{@brady.name_slug}/albums"
    expect(page).to have_content(@album2.name)
  end

  scenario "album index displays when no albums exist" do  
    Album.destroy_all
    visit "families/#{@brady.name_slug}/albums"
    visit current_path
    expect(page).to have_content("You have 0 albums.")
  end

  scenario "shows 0 albums in index with ajax if all deleted" do
    @mike.albums << @album
    visit "families/#{@brady.name_slug}/albums"
    find("div[data-id='1']").find("a.delete_x").click
    find("div[data-id='2']").find("a.delete_x").click
    expect(Album.all.length).to eq(0)
    expect(page).to have_content("You have 0 albums.")
  end

  scenario "can view album from index" do
    visit "families/#{@brady.name_slug}/albums"
    find("div[data-id='2']").first(:xpath, "//a[@href='/families/brady/albums/2']").click
    expect(page).to have_content("Add a Photo")
  end

  scenario "can create album from index" do
    visit "families/#{@brady.name_slug}/albums"
    fill_in "Name", with: "Crazy Awesome Album"
    check('Greg')
    click_button "Create Album"
    expect(page).to have_content("Add a Photo")
  end

  scenario "cannot save album without permissions" do
    visit "families/#{@brady.name_slug}/albums"
    fill_in "Name", with: "Crazy Awesome Album"
    click_button "Create Album"
    expect(page).to have_content("Permissions can't be blank")
  end

  xscenario "can edit an album name" do
    visit "families/#{@brady.name_slug}/albums/1"
    find("span[data-family='1']").click
    fill_in "album_title_field", with: "Even Better"
    find("body").click
    # keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('body').trigger(e);"
    # page.driver.execute_script(keypress)
    expect(page).to have_content(@album.name)
  end

end