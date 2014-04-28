require 'spec_helper'

describe Photo do
  before do
    @photo = create(:photo)
    @album = create(:album)
    @album.photos << @photo
  end
  
  it "belongs to an album" do
    expect(@photo.album).to eq(@album)
  end
end
