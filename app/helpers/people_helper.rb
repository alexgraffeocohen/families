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

      extra_relations = ["maternal_grandmother", "maternal_grandfather", "paternal_grandmother", "paternal_grandfather", "maternal_aunt", "paternal_aunt", "maternal_uncle", "paternal_uncle"]
      possible_relations = [Person::RELATIONSHIPS, extra_relations].flatten

      possible_relations.each do |possible_relation|
        if relation == possible_relation
          admin.send("#{relation}=", member)
          member.save
        end
      end
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
