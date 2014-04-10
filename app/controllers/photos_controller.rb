class PhotosController < ActionController::Base
  before_action :set_photo, only: [:create, :destroy]

  def create
    @photo = Photo.new(photo_params)
    @photo.album_id = @album.id
    @photo.save
  end

  def destroy

    respond_to do |f|
      if current_person == @album.owner
        @photo.destroy
        f.html {redirect_to albums_path}
        f.js {render 'destroy', locals: {family: @family, album: @album, photo: @photo}}
      else
        @msg = "Sorry, you do not own this album."
        f.js {render 'destroy_failure', locals: {msge: @msg}}
      end
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:photo_id]) if params[:photo_id]
    @album = Album.find(params[:album_id])
    @family = Family.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:caption, :data)
  end
end