require_relative '../feature_helper'

feature "Album" do
  before :each do
    @person = create(:person)
    @family = create(:family)
    @family.person_families.create(person: @person)

    @album = create(:album)
    @album2 = create(:album)

    visit '/'
    click_link("Log in")
    fill_in "Email", with: @person.email
    fill_in "Password", with: @person.password
    save_and_open_page
    click_button("Sign in")
  end

  scenario "album index displays all albums" do
    visit 'families/1/albums'
    expect(page).to have_content(@album.name)
    expect(page).to have_content(@album2.name)
  end

  scenario "album index displays when no albums exist" do
    puts Album.all    
    Album.all.delete_all
    visit 'families/1/albums'
    expect(page).to have_content("You have 0 albums.")
  end

  scenario "shows 0 albums in index with ajax if all deleted" do
    within ("div['data-id'='1']") do
      click_link "Delete"
    end
    click_link "Delete"
    expect(Album.all.length).to eq(0)
    expect(page).to have_content("You have 0 albums.")
  end

  scenario "can view ablum from index" do
    within ("div['data-id'='1']") do
      click_link "View"
    end
    expect(page).to have_content("Add a Photo")
  end

  scenario "can edit album from index" do
    within ("div['data-id'='1']") do
      click_link "Edit"
    end
    expect(page).to have_button("Update Album")
  end

  scenario "can create album from index" do
    click_link "Create an album!"
    expect(page).to have_button("Create Album")
  end
end