class Family < ActiveRecord::Base
  has_many :person_families
  has_many :people, :through => :person_families
  has_many :albums
end
