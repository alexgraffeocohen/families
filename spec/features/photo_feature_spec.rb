feature "Photo" do
  before :each do
    album = create(:album)
    @photo = create(:@photo)
    @photo2 = create(:@photo)
    @album << @photo
    @album << @photo2
    visit '/albums/1'
  end

  scenario "album show displays all photos" do
    expect(page).to have_content("@photo.caption")
    expect(page).to have_content("@photo2.caption")
  end

  scenario "belongs to album" do
    expect(@photo.album).to eq(@album)
  end

  scenario "can be added to album" do
  end

  scenario "can be deleted from album" do
  end
end