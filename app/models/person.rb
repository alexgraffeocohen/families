class Person < ActiveRecord::Base
  include Relationable
  include PeopleHelper

  RELATIONSHIPS = ["grandmother", "son", "daughter", "father", "mother", "wife", "husband", "daughter_in_law", "son_in_law", "grandfather", "grandson", "granddaughter", "brother", "sister"]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many   :person_families
  has_many   :families, through: :person_families
  has_many   :albums
  belongs_to :mother, :class_name => Person, :foreign_key => :mother_id
  belongs_to :father, :class_name => Person, :foreign_key => :father_id
  belongs_to :spouse, :class_name => Person, :foreign_key => :spouse_id

  validates :gender, presence: :true

  def add_spouse(spouse)
    self.spouse = spouse
    spouse.spouse = self
    self.save
    spouse.save
  end

  def male?
    gender == "M"
  end

  def female?
    gender == "F"
  end

  # def paternal_grandparents
  #   [grandmothers[:paternal], grandfathers[:paternal]]
  # end

  # def maternal_grandparents
  #   [grandmothers[:maternal], grandfathers[:maternal]]
  # end

  def default_family
    self.families[0]
  end

  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end

  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

  def has_no_password?
    self.encrypted_password.blank?
  end

  def password_match?(params)
    params[:password] == params[:password_confirmation]
  end

  def password_required?
    if !persisted? 
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end

  def permitted_albums
    self.families.collect { |family|
      family.albums.select do |album|
        self.can_see_album?(album)
      end
    }.flatten
  end

  def can_see_album?(album)
    album.relationships_permitted.include?(self.relationship_to(album.owner)) || 
    album.owner == self ||
    album.names_permitted.include?(self.first_name)
  end

  def cannot_see_any_albums?
    permitted_albums.empty?
  end
end

