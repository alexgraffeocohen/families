require 'spec_helper'

describe AlbumsController do
  describe 'GET #index' do
    before :each do
      @brady = create(:family)
      @album1 = create(:album)
      @album2 = create(:album)
      get :index, id: brady.id
    end
    it "assigns all albums to @albums" do
      expect(assigns(:albums)).to match_array([@album1, @album2])
    end

    it "renders the :index template" do 
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do
    before :each do
      @brady = create(:family)
    end
    it "assigns a new Album to @album" do
      get :new, id: @brady.id
      expect(assigns(:album)).to be_a_new(Album)
    end
  end

  describe "POST #create" do
    before :each do 
      @albums = attributes_for(:album)
    end

    it "saves the new album in the database" do
      expect{
        post :create, album: attributes_for(:album, albums_attributes: @albums)}.to change(Album, :count).by(1)
    end
  end
end
