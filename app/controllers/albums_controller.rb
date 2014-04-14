class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :set_family, only: [:create, :new, :index, :show, :edit, :update, :destroy]
  
  def show
  end

  def edit
  end

  def new
    @album = Album.new
    @photo = Photo.new
    @other_members = @family.people.to_a.delete_if {|i| i == current_person}
    @relationships = Person::GROUP_RELATIONSHIPS
  end

  def create
    album = Album.new(album_params)
    album.family_id = find_family(params[:id]).id
    unless params[:album][:parse_permission].nil?
      album.permissions = album.parse(params[:album][:parse_permission])
    end
    
    if album.save
      current_person.albums << album
      redirect_to album_path(Family.friendly.find(params[:id]), album)
    else
      flash[:alert] = "#{album.errors.full_messages}"
      redirect_to :back
    end
  end

  def update
    @album.update(name: params[:album][:name])
    @new_val = params[:album][:name]
  end

  def destroy
    respond_to do |f|
      if current_person == @album.owner
        @album.destroy
        f.html {redirect_to albums_path}
        f.js {render 'destroy', locals: {album: @album, family: @family}}
      else
        @msg = "Sorry, you do not own this album."
        f.html {redirect_to albums_path, notice: @msg}
        f.js {render 'destroy_failure', locals: {msge: @msg}}
      end
    end
  end

  def index
    @albums = current_person.all_permitted("album")
  end

  private

  def set_album
    @album = Album.find(params[:album_id])
  end

  def set_family
    @family = Family.friendly.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:name, :family_id)
  end
end
