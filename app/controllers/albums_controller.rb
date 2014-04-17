class AlbumsController < ApplicationController
  before_action :set_family, only: [:create, :new, :index, :show, :edit, :update, :destroy]
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :only => [:index, :edit] do
    provide_relationships(@family)
  end

  def show
  end

  def edit
  end

  def create
    album = Album.new(album_params)
    album.family_id = find_family(params[:id]).id
    album.permissions = album.parse(params[:album][:parse_permission])
    
    if album.save
      current_person.albums << album
      redirect_to album_path(@family, album)
    else
      flash[:alert] = "#{album.errors.full_messages}"
      redirect_to :back
    end
  end

  def update
    @album.update(name: params[:album][:name])
    @new_val = params[:album][:name]
    render nothing: true
  end

  def destroy
    respond_to do |f|
      if current_person == @album.owner
        @album.destroy
        f.html {redirect_to albums_path}
        f.js {render 'destroy', locals: {album: @album, family: @family}}
      else
        @msg = "Sorry, something went wrong."
        f.html {redirect_to albums_path, notice: @msg}
        f.js {render 'destroy_failure', locals: {msge: @msg}}
      end
    end
  end

  def index
    @album = Album.new
    @photo = Photo.new
    @albums = current_person.all_permitted("album")
  end

  private

  def set_album
    @album = Album.find(params[:album_id])
  end

  def album_params
    params.require(:album).permit(:name, :family_id)
  end
end
