module Assignable

  def son=(member)
    member.father = admin
  end

  def daughter=(member)
    member.mother_id = admin.id
  end

  def husband=(member)
    admin.add_spouse(member)
  end

  def wife=(member)
    admin.add_spouse(member)
  end

  def mother=(member)
    admin.mother = member
  end

  def father=(member)
    admin.father = member
  end

  def father_missing
    !admin.father
  end

  def mother_missing
    !admin.mother
  end

  def sibling=(member)
    member.mother = admin.mother
    member.father = admin.father
  end

  def brother=(member)
    unless father_missing && mother_missing
      admin.sibling = member
    else
      admin.non_rel_brothers << member
    end
  end

  def sister=(member)
    unless father_missing && mother_missing
      admin.sibling = member
    else
      admin.non_rel_sister << member
    end
  end

  def grandmother=(member)
  end

  def grandfather=(member)
  end

  def grandson=(member)
  end

  def graddaughter=(member)
  end

  def father_in_law=(member)
  end

  def mother_in_law=(member)
  end

  def brother_in_law=(member)
  end

  def sister_in_law=(member)
  end

  def aunt=(member)
  end

  def uncle=(member)
  end

  def cousin=(member)
  end

end