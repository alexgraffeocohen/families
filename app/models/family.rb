class Family < ActiveRecord::Base
  has_many :person_families
  has_many :people, :through => :person_families, foreign_key: :person_id
  has_many :albums
  
  extend FriendlyId 
  friendly_id :name_slug

  before_save :save_name_slug

  def save_name_slug
    self.name_slug = name.downcase
  end

  def add_members(members)
    members.each do |family_member|
      person_families.create(person_id: family_member.id)
      family_member.last_name ||= self.name
    end
  end

end
