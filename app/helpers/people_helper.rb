module PeopleHelper

  def members_array(emails, relations)
    emails.zip(relations)
  end

  def rearrange_members(nested_array)
    nested_array.each do |pair|
      if pair[1] == "father" || pair[1] == "mother"
        nested_array.delete(pair)
        nested_array.unshift(pair)
      elsif pair[1][0] == "g"
        nested_array.delete(pair)
        nested_array.push(pair)
      end
    end
  end

  def set_relations(ordered_nested_array, admin)
    ordered_nested_array.each do |pair|
      member = pair[0]
      relation = pair[1]

     # PERSON::RELATIONSHIPS + my extra relations

      PERSON::RELATIONSHIPS.each do |possible_relation|
        if relation == possible_relation
          admin.relation = member
        end
      end
      
      
      
      # elsif relation == "grandmother (maternal)"
      #   admin.maternal_grandmother = member
      # elsif relation == "grandfather (maternal)"
      #   admin.maternal_grandfather = member
      # elsif relation == "grandmother (paternal)"
      #   admin.paternal_grandmother = member
      # elsif relation == "grandfather (paternal)"
      #   admin.paternal_grandfather = member
      
    member.save
    end

    if !admin.children.empty?
      admin.children.each do |child|
        if admin.wife
          child.mother_id = admin.wife.id
          admin.wife.save
        elsif admin.husband
          child.father_id = admin.husband.id
        end
        child.save
        admin.save
      end
    end
  end
end
