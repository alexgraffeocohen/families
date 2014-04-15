module Relationable
  extend ActiveSupport::Concern
  # relations []

  def relationship_to(person)
    Person::RELATIONSHIPS.each do |relationship|
      return relationship if self.send("#{relationship}_to", person)
    end
    "I don't know what.." 
  end

  def daughter_to(person)
    person.daughters.include?(self)
  end

  def son_to(person)
    person.sons.include?(self)
  end

  def brother_to(person)
    person.siblings.include?(self) && self.gender == "M"
  end

  def sister_to(person)
    person.siblings.include?(self) && self.gender == "F"
  end

  def father_to(person)
    person.parents.include?(self) && self.gender == "M"
  end

  def mother_to(person)
    person.parents.include?(self) && self.gender == "F"
  end

  def grandfather_to(person)
    person.grandparents.include?(self) && self.gender == "M"
  end

  def grandmother_to(person)
    person.grandparents.include?(self) && self.gender == "F"
  end

  def grandson_to(person)
    self.grandparents.include?(person) && self.gender == "M"
  end

  def granddaughter_to(person)
    self.grandparents.include?(person) && self.gender == "F"
  end

  def husband_to(person)
    self.spouse == person && self.gender == "M"
  end

  def wife_to(person)
    self.spouse == person && self.gender == "F"
  end

  def son_in_law_to(person)
    if self.spouse
      self.spouse.parents.include?(person) && self.gender == "M"
    end
  end

  def daughter_in_law_to(person)
    if self.spouse
      self.spouse.parents.include?(person) && self.gender == "F"
    end
  end

  def husband
    Person.find_by(spouse_id: self.id, gender: "M")
  end

  def wife
    Person.find_by(spouse_id: self.id, gender: "F")
  end

  def parents
    [mother, father].compact
  end

  def grandsons
    grandchildren.select(&:male?)
  end

  def granddaughters
    grandchildren.select(&:female?)
  end

  def son_in_laws
    children_in_laws.select(&:male?)
  end

  def daughter_in_laws
    children_in_laws.select(&:female?)
  end

  def brothers
    siblings.select {|sibling| sibling.gender == "M"}
  end

  def sisters
    siblings.select {|sibling| sibling.gender == "F"}
  end
  
  def siblings
    Person.where("mother_id = ? OR father_id = ?", mother_id, father_id).where.not("id = ?", self.id)
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

  def children_in_laws
    children.collect { |child| child.spouse }.compact if children  
  end

  def parents_in_law
    spouse.parents.compact if spouse
  end

  def grandchildren
    children.collect { |child| child.children }.compact.flatten if children 
  end

  def grandparents
    (grandmothers + grandfathers).compact
  end

  def grandmothers
    [(mother.mother unless mother.nil?), (father.mother unless father.nil?)].compact
  end

  def grandfathers
     [(mother.father unless mother.nil?), (father.father unless father.nil?)].compact
  end

  def aunts
    [(mother.sisters unless mother.nil?), (father.sisters unless father.nil?)].flatten.compact
  end

  def uncles
    [(mother.brothers unless mother.nil?), (father.brothers unless father.nil?)].flatten.compact
  end

  def great_uncles
    grandparents.collect { |grandparent| grandparent.brothers }.compact.flatten if grandparents
  end

  def great_aunts
    grandparents.collect { |grandparent| grandparent.sisters }.compact.flatten if grandparents
  end

  def nephews
    siblings.collect { |sibling| sibling.sons }.compact.flatten if siblings
  end

  def nieces
    siblings.collect { |sibling| sibling.daughters }.compact.flatten if siblings
  end

  def cousins
    [(mother.nieces + mother.nephews unless mother.nil?), (father.nieces + father.nephews unless father.nil?)].flatten.compact
  end

  def father_in_laws
    parents_in_law.select(&:male?) if parents_in_law
  end
 
  def mother_in_laws
    parents_in_law.select(&:female?) if parents_in_law
  end

  def siblings_in_law
    [brothers_in_law, sisters_in_law].flatten
  end

  def brothers_in_law
    [(wife.brothers unless wife.nil?), (husband.brothers unless husband.nil?)].flatten.compact
  end

  def sisters_in_law
    [(wife.sisters unless wife.nil?), (husband.sisters unless husband.nil?)].flatten.compact
  end
  
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

  def daughter_in_law_to(person)
    self.gender == "F" && person.children.include?(self.spouse)
  end

  def son_in_law_to(person)
    self.gender == "M" && person.children.include?(self.spouse)
  end

  def father_in_law_to(person)
    self.gender == "M" && self.children.include?(self.spouse)
  end

  def mother_in_law_to(person)
    self.gender == "F" && self.children.include?(person.spouse)
  end
end