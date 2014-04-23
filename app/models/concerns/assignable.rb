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
    self.mother.save
    member.gender = "F"
  end

  def maternal_grandfather=(member)
    self.mother.father = member if self.mother
    self.mother.save
    member.gender = "M"
  end

  def paternal_grandmother=(member)
    self.father.mother = member if self.father
    self.father.save
    member.gender = "F"
  end

  def paternal_grandfather=(member)
    self.father.father = member if self.father
    self.father.save
    member.gender = "M"
  end

  def father_in_law=(member)
    self.spouse.father = member if self.spouse
    self.spouse.save
    member.gender = "M"
  end

  def mother_in_law=(member)
    self.spouse.mother = member if self.spouse
    self.spouse.save
    member.gender = "F"
  end

  def add_aunt_or_uncle(member, parent)
    member.mother = (self.send(parent)).mother if (self.send(parent)).mother
    member.father = (self.send(parent)).father if (self.send(parent)).father
  end
  
  def maternal_aunt=(member)
    self.add_aunt_or_uncle(member, "mother")
    member.gender = "F"
  end

  def paternal_aunt=(member)
    self.add_aunt_or_uncle(member, "father")
    member.gender = "F"
  end

  def maternal_uncle=(member)
    self.add_aunt_or_uncle(member, "mother")
    member.gender = "M"
  end

  def paternal_uncle=(member)
    self.add_aunt_or_uncle(member, "father")
    member.gender = "M"
  end

end