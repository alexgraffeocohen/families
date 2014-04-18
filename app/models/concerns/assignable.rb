module Assignable

  def child=(member)
    member.father = self if self.gender == "M"
    member.mother = self if self.gender == "F"
    if self.spouse
      member.father = self.spouse if self.spouse.gender == "M"
      member.mother = self.spouse if self.spouse.gender == "F"
    end
  end

  def son=(member)
    self.child = member
    member.gender = "M"
  end

  def daughter=(member)
    self.child = member
    member.gender = "F"
  end

  def husband=(member)
    self.add_spouse(member)
    member.gender = "M"
  end

  def wife=(member)
    self.add_spouse(member)
    member.gender = "F"
  end

  # def mother=(member)
  #   self.mother = member
  #   member.gender = "F"
  # end

  # def father=(member)
  #   self.father = member
  #   member.gender = "M"
  # end

  def sibling=(member)
    member.mother = self.mother if self.mother
    member.father = self.father if self.father
  end

  def brother=(member)
    self.sibling = member
    member.gender = "M"
  end

  def sister=(member)
    self.sibling = member
    member.gender = "F"
  end

  def maternal_grandmother=(member) 
    self.mother.mother = member if self.mother
    member.gender = "F"
  end

  def maternal_grandfather=(member)
    self.mother.father = member if self.mother
    member.gender = "M"
  end

  def paternal_grandmother=(member)
    self.father.mother = member if self.father
    member.gender = "F"
  end

  def paternal_grandfather=(member)
    self.father.father = member if self.father
    member.gender = "M"
  end

  def father_in_law=(member)
    self.spouse.father = member if self.spouse
    member.gender = "M"
  end

  def mother_in_law=(member)
    self.spouse.mother = member if self.spouse
    member.gender = "F"
  end

  def maternal_aunt_or_uncle=(member)
    member.mother = self.mother.mother if self.mother.mother
    member.father = self.mother.father if self.mother.father
  end

  def paternal_aunt_or_uncle=(member)
    member.mother = self.father.mother if self.father.mother
    member.father = self.father.father if self.father.father
  end

  def maternal_aunt=(member)
    maternal_aunt_or_uncle = member
    member.gender = "F"
  end

  def paternal_aunt=(member)
    paternal_aunt_or_uncle = member
    member.gender = "F"
  end

  def maternal_uncle=(member)
    maternal_aunt_or_uncle = member
    member.gender = "M"
  end

  def paternal_uncle=(member)
    paternal_aunt_or_uncle = member
    member.gender = "M"
  end

end