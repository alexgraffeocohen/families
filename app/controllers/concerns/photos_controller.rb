class PhotosController < ActionController::Base

  def create
    @photo = Photo.new(photo_params)
    @photo.album_id = params[:album_id]
    @photo.save
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :data)
  end
end