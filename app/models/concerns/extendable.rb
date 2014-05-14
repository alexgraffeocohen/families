module Extendable
  def aunts
    [maternal_aunts, paternal_aunts].flatten.compact
  end

  def maternal_aunts
    mother.sisters unless mother.nil?
  end

  def paternal_aunts
    father.sisters unless father.nil?
  end

  def uncles
    [maternal_uncles, paternal_uncles].flatten.compact
  end

  def maternal_uncles
    mother.brothers unless mother.nil?
  end

  def paternal_uncles
    father.brothers unless father.nil?
  end

  def aunts_and_uncles
    [aunts, uncles].flatten
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
    [(maternal_nieces + maternal_nephews unless mother.nil?), (paternal_nieces + paternal_nephews unless father.nil?)].flatten.compact
  end

  def maternal_nieces
    mother.nieces
  end

  def maternal_nephews
    mother.nephews
  end

  def paternal_nieces
    father.nieces
  end

  def paternal_nephews
    father.nephews
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
    set_sib_in_laws("brothers", "husband")
  end

  def sister_in_laws
    set_sib_in_laws("sisters", "wife")
  end

  def set_sib_in_laws(gender_sib, gender_spouse)
    array = []
    array << sib_spouses(gender_spouse) << (wife.send(gender_sib) unless wife.nil?) << (husband.send(gender_sib) unless husband.nil?)
    array.flatten.compact
  end

  def sib_spouses(gender_spouse)
    brothers_spouses = self.brothers.map { |brother| brother.send(gender_spouse) }
    sisters_spouses  = self.sisters.map { |sister| sister.send(gender_spouse) }

    brothers_spouses + sisters_spouses
  end
end