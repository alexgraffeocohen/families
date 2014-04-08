feature "Album" do
  before :each do
    visit '/albums'
  end

  scenario "album index displays all albums" do

  end

  scenario "album index displays when no albums exist" do
    Album.destroy_all
    expect(page).to have_content("You have 0 albums.")
  end

  scenario "can delete album from index" do
    expect(click_link "Delete").to change(Album.all.length).by(-1)
  end

  scenario "can create ablum from index" do
    click_link "Create an album!"
  end

  scenario "can edit album from index" do
    click_link "Edit"
  end

  scenario "can view album from index" do
    click_link "View"
  end
end