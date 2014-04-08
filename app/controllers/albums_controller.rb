class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  
  def show
  end

  def edit
    render 'form'
  end

  def new
    @album = Album.new
    render 'form'
  end

  def create
    album = Album.create(album_params)
    redirect_to album_path(album)
    album.owner = current_user
  end

  def update
    @album.update(album_params)

    if @album.save
      redirect_to @album, :notice => "User successfully edited"
    else
      render 'form' 
      flash[:alert] = "Sorry, could not update."
    end
  end

  def destroy
    if current_user == album.owner
      @album.destroy
      redirect_to albums_path
    else
      flash[:alert] = "Sorry, you do not own this album."
      redirect_to :back
    end
  end

  def index
    @albums = Album.all
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:name, :date)
  end
end
