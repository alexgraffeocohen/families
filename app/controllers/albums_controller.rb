class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit]
  
  def show
  end

  def edit
    render 'form'
  end

  def new
    @album = Album.new
  end

  def index
    @albums = Album.all
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end
end
