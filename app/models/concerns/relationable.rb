module Relationable
  extend ActiveSupport::Concern
  # relations []

  def relationship_to(person)
    Person::RELATIONSHIPS.each do |relationship|
      return relationship.gsub("_", "-") if self.send("#{relationship}_to", person)
    end
    "I don't know what.." 
  end

  def child_to(person)
    person.children.include?(self)
  end

    def daughter_to(person)
      self.gender == "F" && child_to(person)
    end

    def son_to(person)
      self.gender == "M" && child_to(person)
    end

  def sibling_to(person)
    person.siblings.include?(self)
  end

    def brother_to(person)
      self.gender == "M" && sibling_to(person)
    end

    def sister_to(person)
      self.gender == "F" && sibling_to(person)
    end

  def parent_to(person)
    person.parents.include?(self)
  end

    def father_to(person)
      self.gender == "M" && parent_to(person)
    end

    def mother_to(person)
      self.gender == "F" && parent_to(person)
    end

  def grandparent_to(person)
    person.grandparents.include?(self)
  end

    def grandfather_to(person)
       self.gender == "M" && person.grandparents.include?(self)
    end

    def grandmother_to(person)
      self.gender == "F" && person.grandparents.include?(self)
    end

  def grandchild_to(person)
    self.grandparents.include?(person)
  end

    def grandson_to(person)
       self.gender == "M" && grandchild_to(person)
    end

    def granddaughter_to(person)
      self.gender == "F" && grandchild_to(person)
    end

  def spouse_to(person)
    self.spouse == person
  end

    def husband_to(person)
      self.gender == "M" && spouse_to(person)
    end

    def wife_to(person)
      self.gender == "F" && spouse_to(person)
    end

  def child_in_law_to(person)
    person.children.include?(self.spouse)
  end

    def daughter_in_law_to(person)
      self.gender == "F" && child_in_law_to(person)
    end

    def son_in_law_to(person)
      self.gender == "M" && child_in_law_to(person)
    end

  def parent_in_law_to(person)
    self.children.include?(person.spouse)
  end

    def father_in_law_to(person)
      self.gender == "M" && parent_in_law_to(person)
    end

    def mother_in_law_to(person)
      self.gender == "F" && parent_in_law_to(person)
    end

  def aunt_or_uncle_to(person)
    person.parents.any? { |parent| self.siblings.include?(parent) }
  end

    def aunt_to(person)
      self.gender == "F" && aunt_or_uncle_to(person)
    end

    def uncle_to(person)
      self.gender == "M" && aunt_or_uncle_to(person)
    end

  def sibling_in_law_to(person)
    ((self.spouse.siblings.include?(person) if self.spouse) ||
    (self.siblings.include?(person.spouse) if person.spouse))
  end

    def brother_in_law_to(person)
      self.gender == "M" && sibling_in_law_to(person)
    end

    def sister_in_law_to(person)
      self.gender == "F" && sibling_in_law_to(person)
    end

  def niece_or_nephew_to(person)
    self.parents.any? { |parent| person.siblings.include?(parent) }
  end

    def niece_to(person)
      self.gender == "F" && niece_or_nephew_to(person)
    end

    def nephew_to(person)
      self.gender == "M" && niece_or_nephew_to(person)
    end

  def cousin_to(person)
    self.parents.any? { |parent| parent.aunt_or_uncle_to(person) }
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

  def grandchildren
    children.collect { |child| child.children }.compact.flatten if children 
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
    if mother_id || father_id
      Person.where("mother_id = ? OR father_id = ?", mother_id, father_id).where.not("id = ?", self.id)
    else
      []
    end
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

  def aunts_and_uncles
    [aunts, uncles].flatten
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

  def nieces_and_nephews
    [nieces, nephews].flatten
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
    [brother_in_laws, sister_in_laws].flatten
  end

  def brother_in_laws
    from_brothers = brothers.map { |brother| brother.husband }
    from_sisters  = sisters.map { |sister| sister.husband }
    [(wife.brothers unless wife.nil?), from_brothers, from_sisters, (husband.brothers unless husband.nil?)].flatten.compact
  end

  def sister_in_laws
    from_brothers = brothers.map { |brother| brother.wife }
    from_sisters  = sisters.map { |sister| sister.wife }
    [(wife.sisters unless wife.nil?), from_sisters, from_brothers, (husband.sisters unless husband.nil?)].flatten.compact
  end
end