class Person < ActiveRecord::Base
  include Relationable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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

  def brothers
    siblings.select {|sibling| sibling.gender == "M"}
  end

  def sisters
    siblings.select {|sibling| sibling.gender == "F"}
  end

  def children
    Person.where("mother_id = ? OR father_id = ?", self.id, self.id)
  end

  def sons
    people = Person.where("mother_id = ? OR father_id = ?", self.id, self.id)
    people.select(&:male?)
  end

  def daughters
    people = Person.where("mother_id = ? OR father_id = ?", self.id, self.id)
    people.select(&:female?)
  end

  def grandparents
    (grandmothers + grandfathers).compact
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

  def maternal_grandmother=(person) 
    self.mother.mother = person
  end

  def maternal_grandfather=(person)
    self.mother.father = person
  end

  def paternal_grandmother=(person)
    self.father.mother_id = person.id
  end

  def paternal_grandfather=(person)
    self.father.father_id = person.id
  end

  def grandmothers
    [(mother.mother unless mother.nil?), (father.mother unless father.nil?)]
  end

  def grandfathers
     [(mother.father unless mother.nil?), (father.father unless father.nil?)]
  end

  def default_family
    self.families[0]
  end

end

