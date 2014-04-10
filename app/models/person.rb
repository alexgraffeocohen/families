class Person < ActiveRecord::Base
  include Relationable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many   :person_families
  has_many   :families, through: :person_families
  has_many   :albums
  belongs_to :mother, :class_name => Person, :foreign_key => :mother_id
  belongs_to :father, :class_name => Person, :foreign_key => :father_id
  belongs_to :spouse, :class_name => Person, :foreign_key => :spouse_id

  def add_spouse(spouse)
    self.spouse = spouse
    spouse.spouse = self
    self.save
    spouse.save
  end

  def husband
    Person.find_by(spouse_id: self.id, gender: "M")
  end

  def wife
    Person.find_by(spouse_id: self.id, gender: "F")
  end
  
  def parents
    [mother, father]
  end

  def siblings
    Person.where("mother_id = ? OR father_id = ?", mother_id, father_id).where.not("id = ?", self.id)
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
  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  def password_match?(params)
    params[:password] == params[:password_confirmation]
  end

  def password_required?
  # Password is required if it is being set, but not for new records
    if !persisted? 
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end

  def can_see_album?(album)
    album.relationships_permitted.include?(self.relationship_to(album.owner))
  end
end

