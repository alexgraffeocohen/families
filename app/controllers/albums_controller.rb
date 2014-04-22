class AlbumsController < ApplicationController
  before_action :set_family, only: [:create, :new, :index, :show, :edit, :update, :destroy]
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :only => [:index, :edit] do
    provide_relationships(@family)
  end

  def show
    @permitted_except_viewer = @album.all_permitted_members.gsub(current_person.first_name, "You")
  end

  def edit
  end

  def create
    @album = Album.new(album_params)
    @album.family_id = find_family(params[:id]).id
    @album.permissions = @album.parse(params[:album][:parse_permission])
    respond_to do |f|
      if @album.save
        current_person.albums << @album
        f.js { render js: "window.location='#{album_path(@family, @album)}'" }
      else
        @msg = print_errors_for(@album)
        f.js {render 'layouts/create_failure', locals: {msge: @msg}}
      end
    end
  end

  def update
    @album.update(name: params[:album][:name])
    @new_val = params[:album][:name]
    render nothing: true
  end

  def destroy
    destroy_response(@album)
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
