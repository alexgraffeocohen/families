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
      
      if ["son", "daughter"].include?(relation)
        if admin.male?
          member.father_id = admin.id
        elsif admin.female?
          member.mother_id = admin.id
        end
      elsif relation == "mother"
        admin.mother_id = member.id
      elsif relation == "father"
        admin.father_id = member.id
      elsif ["husband", "wife"].include?(relation)
        admin.add_spouse(member)
      elsif relation == "grandmother (maternal)"
        admin.maternal_grandmother = member
      elsif relation == "grandfather (maternal)"
        admin.maternal_grandfather = member
      elsif relation == "grandmother (paternal)"
        admin.paternal_grandmother = member
      elsif relation == "grandfather (paternal)"
        admin.paternal_grandfather = member
      elsif ["brother", "sister"].include?(relation)
        member.mother_id = admin.mother_id if admin.mother
        member.father_id = admin.father_id if admin.father
      end
    
    member.save
    end

    if !admin.children.empty?
      admin.children.each do |child|
        if admin.wife
          child.mother_id = admin.wife.id
        elsif admin.husband
          child.father_id = admin.husband.id
        end
        child.save
        admin.wife.save
        admin.save
      end
    end
  end
end
