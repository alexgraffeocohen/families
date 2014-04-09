require 'spec_helper'

describe Album do
  it "has photos" do
    album = create(:album)
    photo = create(:photo)
    album.photos << photo
    # binding.pry
    expect(album.photos).to include photo
  end

  it "belongs to a family" do
  end
end
