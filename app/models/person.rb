class Person < ActiveRecord::Base
  include Relationable
  include NonRelationable
  include PeopleHelper
  include Assignable

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

  def add_spouse(spouse)
    self.spouse = spouse
    spouse.spouse = self
    self.save
    spouse.save
  end
  
  def admin?
    admin == 1
  end

  def current_relationships
    relationships = my_family_members.collect do |member|
      [member, member.relationship_to(self)]
    end.uniq
    new_rels =  relationships.collect do |rel|
      case rel[1]
      when "grandmother", "grandfather"
        if self.father && self.father.parents.include?(rel[0])
          "paternal " + rel[1]
        elsif self.mother && self.mother.parents.include?(rel[0])
          "maternal " + rel[1]
        end
      when "aunt", "uncle"
        if self.father && self.father.siblings.include?(rel[0])
          "paternal " + rel[1]
        elsif self.mother && self.mother.siblings.include?(rel[0])
          "maternal " + rel[1]
        end
      else
        rel[1]
      end
    end
  end

  def mother=(member)
    write_attribute(:mother_id, member.id)
    member.gender = "F"
  end

  def father=(member)
    write_attribute(:father_id, member.id)
    member.gender = "M"
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
    owned_by_others = self.my_family_members.collect { |member|
                        member.send(total).select do |object|
                          self.can_see?(object)
                        end
                      }
    owned_by_others << self.send(total)
    owned_by_others.flatten
  end

  def can_see?(object)
    object.relationships_permitted.include?(self.relationship_to(object.owner).gsub("-","_")) || 
    object.owner == self ||
    object.people_permitted.include?(self.permission_slug)
  end

  def cannot_see_any?(class_name)
    all_permitted(class_name).empty?
  end

  def checkbox_hash
    singular = [["mother", "father"], ["husband", "wife"]]
    new_hash ||= {}.tap do |hash|
      Permissable::PERMISSION_HASH.values.each_with_index do |relationships, index|
        if singular.include?(relationships)
          singular_checkbox_hash(relationships, index, hash)
        else
          group_checkbox_hash(relationships, index, hash)
        end
        hash[index+1] = [] if hash[index+1].nil?
        hash[index+1].flatten!
      end
    end
  end
  
  def my_family_members
    GROUP_RELATIONSHIPS.collect { |relationship| 
      self.send(relationship) 
    }.compact.flatten.
    select { |member| member.confirmed? }
  end

  def confirmed?
    !self.confirmed_at.nil?
  end

  # def method_missing
  #   puts "hit"
  #   # if method_sym
  #   #   .map {|rel| rel.permission_slug}
  #   # else
  #   #   .permission_slug
  # end

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

  def singular_checkbox_hash(relationships, index, hash)
    check_relationships(relationships, index, hash)
  end

  def check_relationships(relationships, index, hash, group = nil)
    for length in 0..1
      r = relationships[length]
      
      if r
        if group
          value = self.send(r.pluralize).map {|rel| rel.permission_slug}.compact 
        elsif self.send(r)
          value = self.send(r).permission_slug
        end
      end

      set_hash(hash, index, value)
    end
  end

  def set_hash(hash, index, value)
    hash[index+1] = [] if hash[index+1].nil?
    hash[index+1] << value
  end

  def group_checkbox_hash(relationships, index, hash)
    check_relationships(relationships, index, hash, 'group')
  end
end

