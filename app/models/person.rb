class Person < ActiveRecord::Base
  include Relationable
  include PeopleHelper

  attr_accessor :checkbox_hash

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

  PERMISSION_HASH2 = {
      "1" => ["brother", "sister"],
      "2" => ["mother", "father"],
      "3" => ["son", "daughter"],
      "4" => ["grandfather", "grandmother"],
      "5" => ["grandson", "granddaughter"],
      "6" => ["son_in_law", "daughter_in_law"],
      "7" => ["father_in_law", "mother_in_law"],
      "8" => ["husband", "wife"],
      "9" => ["aunt", "uncle"],
      "10" => ["niece", "nephew"],
      "11" => ["cousin"],
      "12" => ["brother_in_law", "sister_in_law"]
    }
  def add_spouse(spouse)
    self.spouse = spouse
    spouse.spouse = self
    self.save
    spouse.save
  end

  def admin?
    admin == 1
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

  def checkbox_hash
    singular = [["mother", "father"], ["husband", "wife"]]
    new_hash ||= {}.tap do |hash|
      PERMISSION_HASH2.values.each_with_index do |relationships, index|
        if singular.include?(relationships)
          if self.send(relationships[0])
            hash[index+1] = [self.send(relationships[0]).permission_slug]
          end
          if relationships[1]
            if self.send(relationships[1])
              (hash[index+1] << self.send(relationships[1]).permission_slug)
            end
          end
        else
          hash[index+1] = self.send(relationships[0].pluralize).map {|rel| rel.permission_slug}
          if relationships[1]
            hash[index+1] << self.send(relationships[1].pluralize).map {|rel| rel.permission_slug}
          end
        end
        hash[index+1] = [] if hash[index+1].nil?
        hash[index+1].flatten!
      end
    end
  end
  
  def my_family_members
    GROUP_RELATIONSHIPS.collect do |relationship|
      self.send(relationship)
    end.compact.flatten
  end

  private 

  def set_permission_slug
    if self.permission_slug.nil?
      self.permission_slug = "#{email.split("@").first.downcase.gsub(' ', '_').gsub('.','')}#{id}" 
      self.save
    end
  end
  
  def set_age
    self.age = DateTime.now.year - self.birthday.year if self.birthday
  end
end

