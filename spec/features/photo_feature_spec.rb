require 'spec_helper'

feature "Photo" do
  before :each do
    @family = create(:family)
    @album = create(:album)
    @family.albums << @album
    visit '/albums/1'
  end

context "adding photos" do
  before :each do
    visit '/families/1/albums/1'
    click_button("Choose file")
  end

  xscenario "album show displays all photos" do
    expect(page).to have_content(@photo.caption)
    expect(page).to have_content(@photo2.caption)
  end

  xscenario "belongs to album" do
    expect(@photo.album).to eq(@album)
  end
end

  xscenario "can be added to album" do
  end

  xscenario "can be deleted from album" do
  end
end