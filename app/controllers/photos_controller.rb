class PhotosController < ActionController::Base

  def create
    @photo = Photo.new(photo_params)
    @photo.album_id = params[:album_id]
    @photo.save
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    @album = Album.find(params[:album_id])
    respond_to do |f|
      if current_person == @album.owner
        @photo.destroy
        f.html {redirect_to albums_path}
        f.js {render 'destroy', locals: {album: @album, photo: @photo}}
      else
        @msg = "Sorry, you do not own this album."
        f.js {render 'destroy_failure', locals: {msge: @msg}}
      end
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :data)
  end
end