module Relationable
  extend ActiveSupport::Concern

  def relationship_to(person)
    Person::RELATIONSHIPS.each do |relationship|
      begin
        if self.send("#{relationship}_to", person)
          return relationship.gsub("_", "-")
        end 
      rescue
        next
      end
    end
    "I don't know what.." 
  end

  def sanitized_relationship_to(person)
    relationship = self.relationship_to(person)
    if relationship.include?("maternal") || relationship.include?("paternal")
      stripped_relation(relationship)
    else
      relationship
    end
  end

  def stripped_relation(relationship)
    relationship.split("-")[1]
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

  def maternal_grandparents
    [maternal_grandmother, maternal_grandfather].flatten.compact
  end

  def paternal_grandparents
    [paternal_grandmother, paternal_grandfather].flatten.compact
  end

  def grandmothers
    [maternal_grandmother, paternal_grandmother].flatten.compact
  end

  def maternal_grandmother
    mother.mother unless mother.nil?
  end

  def paternal_grandmother
    father.mother unless father.nil?
  end

  def grandfathers
    [maternal_grandfather, paternal_grandfather].flatten.compact
  end

  def maternal_grandfather
    mother.father unless mother.nil?
  end

  def paternal_grandfather
    father.father unless father.nil?
  end

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