module PeopleHelper

  def members_array(emails, relations)
    emails.zip(relations)
  end

  def rearrange_members(nested_array)
    aunts_and_uncles = []
    first = []
    grandparents = []
    remainder = []
    nested_array.each do |pair|
      if pair[1] == "father" || pair[1] == "mother"
        first.push(pair)
      elsif pair[1] == "wife" || pair[1] == "husband"
        first.push(pair)
      elsif pair[1].include?("grand")
       grandparents.push(pair)
      elsif pair[1].include?("aunt")
        aunts_and_uncles.push(pair)
      elsif pair[1].include?("uncle")
        aunts_and_uncles.push(pair)
      else
        remainder.push(pair)
      end
    end
    array = [first, remainder, grandparents, aunts_and_uncles].flatten(1)
  end

  def set_relations(ordered_nested_array, admin)
    ordered_nested_array.each do |pair|
      member = pair[0]
      relation = pair[1]

      extra_relations = ["maternal_grandmother", "maternal_grandfather", "paternal_grandmother", "paternal_grandfather", "maternal_aunt", "paternal_aunt", "maternal_uncle", "paternal_uncle"]
      possible_relations = [Person::RELATIONSHIPS, extra_relations].flatten

      possible_relations.each do |possible_relation|
        relation_param = relation.gsub(/[ |-]/, '_')
        if relation_param == possible_relation
          admin.send("#{relation_param}=", member)
          member.save
        end
      end
    end

    # if !admin.children.empty?
    #   admin.children.each do |child|
    #     if admin.wife
    #       child.mother_id = admin.wife.id
    #       admin.wife.save
    #     elsif admin.husband
    #       child.father_id = admin.husband.id
    #     end
    #     child.save
    #     admin.save
    #   end
    # end
  end
end
