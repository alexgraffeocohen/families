class Person < ActiveRecord::Base
  include Relationable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many   :person_families
  has_many   :families, :through => :person_families
  has_many   :albums
  belongs_to :mother, :class_name => Person, :foreign_key => :mother_id
  belongs_to :father, :class_name => Person, :foreign_key => :father_id
  belongs_to :spouse, :class_name => Person, :foreign_key => :spouse_id

  after_save :check_for_spouse if :spouse_changed

  def spouse_changed
    changed_attributes.keys.include?('spouse_id')
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

  def grandparents
    (grandmothers.values + grandfathers.values).compact
  end

  # def paternal_grandparents
  #   [grandmothers[:paternal], grandfathers[:paternal]]
  # end

  # def maternal_grandparents
  #   [grandmothers[:maternal], grandfathers[:maternal]]
  # end

  def grandmothers
    {maternal: (mother.mother unless mother.nil?), paternal: (father.mother unless father.nil?)}
  end

  def grandfathers
    {maternal: (mother.father unless mother.nil?), paternal: (father.father unless father.nil?)}
  end

  def default_family
    self.families[0]
  end

  private

  def check_for_spouse
    partner = Person.where(id: self.spouse_id)[0]
    partner.spouse_id = self.id if partner
    #send notification
    partner.save if partner && self.spouse_id != partner.id && self.id != partner.spouse_id  
  end
end

