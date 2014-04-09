module Relationable
  extend ActiveSupport::Concern
  
  def relationship_to(person)
    case 
      when wife_to(person)            then "wife"
      when husband_to(person)         then "husband"
      when mother_to(person)          then "mother"
      when father_to(person)          then "father"
      when sister_to(person)          then "sister"
      when brother_to(person)         then "brother"
      when son_to(person)             then "son"
      when daughter_to(person)        then "daughter" 
      when grandson_to(person)        then "grandson"      
      when granddaughter_to(person)   then "granddaughter" 
      when grandfather_to(person)     then "grandfather" 
      when grandmother_to(person)     then "grandmother" 
      when son_in_law_to(person)      then "son-in-law" 
      when daughter_in_law_to(person) then "daughter-in-law" 
    else 
      "I don't know what..."
    end
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
end