module Permissable
  extend ActiveSupport::Concern


  PERMISSION_HASH = {
      "1" => ["brother", "sister"],
      "2" => ["mother", "father"], # this needs to be singular
      "3" => ["son", "daughter"],
      "4" => ["grandfather", "grandmother"],
      "5" => ["grandson", "granddaughter"],
      "6" => ["son_in_law", "daughter_in_law"],
      "7" => ["father_in_law", "mother_in_law"],
      "8" => ["husband", "wife"] #this needs to be singular
    }
  attr_reader :parse_permission

  def parse(permissions_array)
    permissions_array.join(" ")
  end

  def relationships_permitted    
    PERMISSION_HASH.map { |key, value| value if permissions.include?(key) }.compact.flatten
  end

  def names_permitted
    permission_str = permissions.split(" ")
    permission_str.select {|permission| permission.match(/[A-Za-z]/)}
  end

  def all_permitted_members
    self.family.people.collect do |member|
      member.first_name if member.can_see?(self)
    end.compact.join(", ")
  end
  
  def get_names(num)
    singular = ["mother", "father", "husband", "wife"]
    relations = PERMISSION_HASH[num]
    relatives = relations.map do |relation|
      if singular.include?(relation)
        current_person.send(relation).first_name if current_person.send(relation)
      else
        current_person.send(relation.pluralize).map {|rel| rel.first_name}
      end
    end.compact.flatten
  end
end