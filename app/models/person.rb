class Person < ActiveRecord::Base
  include Relationable
  include PeopleHelper

  mount_uploader :profile_photo, DataUploader

  RELATIONSHIPS = ["brother", "sister", "father", "mother", "son", "daughter", "grandmother", "grandfather", "grandson", "granddaughter", "wife", "husband", "daughter_in_law", "son_in_law", "father_in_law", "mother_in_law", "aunt", "uncle", "nephew", "niece", "cousin", "brother_in_law", "sister_in_law"]
  GROUP_RELATIONSHIPS = ["siblings", "parents", "children", "grandparents", "grandchildren", "children_in_laws", "parents_in_law", "spouse", "aunts_and_uncles", "nieces_and_nephews", "cousins", "siblings_in_law"]
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many   :person_families
  has_many   :families, through: :person_families
  has_many   :albums
  has_many   :events
  has_many   :conversations
  belongs_to :mother, :class_name => Person, :foreign_key => :mother_id
  belongs_to :father, :class_name => Person, :foreign_key => :father_id
  belongs_to :spouse, :class_name => Person, :foreign_key => :spouse_id

  before_save :set_age
  after_save  :set_permission_slug

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

  def all_permitted(class_name)
    total = class_name.downcase.pluralize
    self.families.collect { |family|
      family.send(total).select do |object|
        self.can_see?(object)
      end
    }.flatten
  end

  def can_see?(object)
    object.relationships_permitted.include?(self.relationship_to(object.owner)) || 
    object.owner == self ||
    object.people_permitted.include?(self.permission_slug)
  end

  def cannot_see_any?(class_name)
    all_permitted(class_name).empty?
  end

  def my_family_members
    GROUP_RELATIONSHIPS.collect do |relationship|
      self.send(relationship)
    end.compact.flatten
  end

  private 

  def set_permission_slug
    if self.permission_slug.nil?
      self.permission_slug = "#{first_name.downcase.gsub(' ', '_').gsub('.','')}#{id}" 
      self.save
    end
  end
  
  def set_age
    self.age = DateTime.now.year - self.birthday.year if self.birthday
  end
end

