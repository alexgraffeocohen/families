feature "Album" do
  before :each do
    album = create(:album)
    album2 = create(:album)
    visit '/albums'
  end

  scenario "album index displays all albums" do
    expect(page).to have_content("album.name")
    expect(page).to have_content("album2.name")
  end

  scenario "album index displays when no albums exist" do
    Album.destroy_all
    expect(page).to have_content("You have 0 albums.")
  end

  scenario "can delete album from index" do
    within ("div[data-id=1]") do
      click_link "Delete"
    end
    expect(Album.all.length).to eq(1)
    expect(page).to_not have_content(album.name)
  end

  scenario "can view ablum from index" do
    within ("div[data-id=1]") do
      click_link "View"
    end
    expect(page).to have_content("Add a Photo")
  end

  scenario "can edit album from index" do
    within ("div[data-id=1]") do
      click_link "Edit"
    end
    expect(page).to have_button("Update Album")
  end

  scenario "can create album from index" do
    click_link "Create an album!"
    expect(page).to have_button("Create Album")
  end
end