module PeopleHelper

  def members_array(emails, relations)
    emails.zip(relations)
  end

  def parse_members(members)

  end

  def set_relations(nested_array, admin)
    nested_array.each do |pair|
      pair.each do |member, relation|
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
        elsif relation = "spouse"
          admin.spouse_id = member.id
        elsif relation == "maternal grandmother"
          admin.maternal_grandmother(member)
        elsif relation == "maternal grandfather"
          admin.maternal_grandfather(member)
        elsif relation == "paternal grandmother"
          admin.paternal_grandmother(member)
        elsif relation == "paternal grandfather"
          admin.paternal_grandfather(member)
        elsif ["brother", "sister"].include?(relation)
          member.mother_id = admin.mother_id if admin.mother
          member.father_id = admin.father_id if admin.father
        end
      end
    end
  end




        
      end
    end
  end

end
