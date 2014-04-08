class Album < ActiveRecord::Base
  belongs_to :family
  belongs_to :owner, class_name: Person, foreign_key: :person_id
  has_many :photos
end
