class Family < ActiveRecord::Base
  has_many :person_families
  has_many :people, :through => :person_families
  has_many :albums
  
  extend FriendlyId 
  friendly_id :name_slug

  before_save :save_name_slug

  def save_name_slug
    self.name_slug = name.downcase
  end

end
