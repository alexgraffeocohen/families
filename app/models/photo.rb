class Photo < ActiveRecord::Base
  belongs_to :album

  mount_uploader :data, DataUploader
end
