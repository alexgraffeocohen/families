class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  
  def show
  end

  def edit
  end

  def new
    @album = Album.new
  end

  def create
    album = Album.new(album_params)
    album.family_id = params[:family_id]
    album.save
    current_person.albums << album
    redirect_to album_path(Family.find(params[:id]),album)
  end

  def update
    @album.update(album_params)

    if @album.save
      redirect_to albums_path(@family, @album), :notice => "User successfully edited"
    else
      render 'form' 
      flash[:alert] = "Sorry, could not update."
    end
  end

  def destroy
    respond_to do |f|
      if current_person == @album.owner
        @album.destroy
        f.html {redirect_to albums_path}
        f.js {render 'destroy', locals: {album: @album, family: @family}}
      else
        flash[:alert] = "Sorry, you do not own this album."
        f.js {render 'destroy_failure'}
      end
    end
  end

  def index
    @albums = Album.all
  end

  private

  def set_album
    @family = Family.find(params[:id])
    @album = Album.find(params[:album_id])
  end

  def album_params
    params.require(:album).permit(:name, :date, :family_id)
  end
end
