class Family < ActiveRecord::Base
  has_many :person_families
  has_many :people, :through => :person_families, foreign_key: :person_id
  has_many :albums, dependent: :destroy
  has_many :conversations, dependent: :destroy
  has_many :events, dependent: :destroy

  validates_presence_of :name

  before_destroy :destroy_members

  extend FriendlyId 
  friendly_id :name_slug

  before_save :save_name_slug

  def add_members(members)
    members.each do |family_member|
      person_families.create(person_id: family_member.id)
      family_member.last_name ||= self.name
    end
  end

  private

  def save_name_slug
    unless Family.find_by(name_slug: name.downcase)
      self.name_slug = name.downcase
    else
      count = Family.where("name_slug = ?",name.downcase).length
      self.name_slug = "#{name.downcase}#{count-1}" if self.name_slug.nil?
    end
  end

  def destroy_members
    people.each do |member|
      unless member.families.length > 1
        member.destroy
      end
    end
  end
end
