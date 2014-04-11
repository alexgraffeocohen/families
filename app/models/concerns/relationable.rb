module Relationable
  extend ActiveSupport::Concern
  # relations []

  def relationship_to(person)
    Person::RELATIONSHIPS.each { |relationship|
      if self.send("#{relationship}_to", person)
        return relationship
      else
        return "I don't know what.." 
      end
    }
  end

  def daughter_to(person)
    self.parents.include?(person) && self.gender == "F"
  end

  def son_to(person)
    self.parents.include?(person) && self.gender == "M"
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

  def children_in_laws
    children.collect { |child| child.spouse } if children  
  end

  def grandchildren
    children.collect { |child| child.children }.flatten if children 
  end

  def grandparents
    (grandmothers + grandfathers).compact
  end

  def grandmothers
    [(mother.mother unless mother.nil?), (father.mother unless father.nil?)]
  end

  def grandfathers
     [(mother.father unless mother.nil?), (father.father unless father.nil?)]
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
end