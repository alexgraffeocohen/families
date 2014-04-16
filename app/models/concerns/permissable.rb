module Permissable
  extend ActiveSupport::Concern


  PERMISSION_HASH = {
      "1" => ["brother", "sister"],
      "2" => ["mother", "father"],
      "3" => ["son", "daughter"],
      "4" => ["grandfather", "grandmother"],
      "5" => ["grandson", "granddaughter"],
      "6" => ["son_in_law", "daughter_in_law"],
      "7" => ["father_in_law", "mother_in_law"],
      "8" => ["husband", "wife"],
      "9" => ["aunt", "uncle"],
      "10" => ["niece", "nephew"],
      "11" => ["cousin"],
      "12" => ["brother_in_law", "sister_in_law"]
    }
  attr_reader :parse_permission

  def parse(permissions_array)
    permissions_array.join(" ")
  end

  def relationships_permitted    
    PERMISSION_HASH.map { |key, value| value if permissions.match(/(?<![a-z])#{key}/) }.compact.flatten
  end

  def people_permitted
    permission_str = permissions.split(" ")
    permission_str.select { |permission| permission.match(/(?<=[a-z])\d+/) }
  end

  def all_permitted_members
    self.owner.my_family_members.collect do |member|
      member.first_name if member.can_see?(self)
    end.compact.join(", ")
  end

  def get_people(permission_key)
    current_person.checkbox_hash[permission_key.to_i]
  end

  def get_relation(slug)
    relation = Person.find_by(permission_slug: slug).relationship_to(current_person)
    PERMISSION_HASH.map do |key, value|
      key if value.include?(relation)
    end.compact.first
  end
end