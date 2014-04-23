module Findable
  extend ActiveSupport::Concern

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

  def maternal_grandparent_to(person)
    person.maternal_grandparents.include?(self)
  end

  def paternal_grandparent_to(person)
    person.paternal_grandparents.include?(self)
  end

    def maternal_grandfather_to(person)
      self.gender == "M" && maternal_grandparent_to(person)
    end

    def paternal_grandfather_to(person)
      self.gender == "M" && paternal_grandparent_to(person)
    end

    def maternal_grandmother_to(person)
      self.gender == "F" && maternal_grandparent_to(person)
    end

    def paternal_grandmother_to(person)
      self.gender == "F" && paternal_grandparent_to(person)
    end

    # def grandfather_to(person)
    #    self.gender == "M" && person.grandparents.include?(self)
    # end

    # def grandmother_to(person)
    #   self.gender == "F" && person.grandparents.include?(self)
    # end

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

    def paternal_aunt_to(person)
      self.gender == "F" && person.paternal_aunts.include?(self)
    end

    def maternal_aunt_to(person)
      self.gender == "F" && person.maternal_aunts.include?(self)
    end

    def paternal_uncle_to(person)
      self.gender == "M" && person.paternal_uncles.include?(self)
    end

    def maternal_uncle_to(person)
      self.gender == "M" && person.maternal_uncles.include?(self)
    end

    # def uncle_to(person)
    #   self.gender == "M" && aunt_or_uncle_to(person)
    # end

    # def aunt_to(person)
    #   self.gender == "F" && aunt_or_uncle_to(person)
    # end

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
  
end