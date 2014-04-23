module Permissable
  extend ActiveSupport::Concern


  PERMISSION_HASH = {
      "1" => ["brother", "sister"],
      "2" => ["mother", "father"],
      "3" => ["son", "daughter"],
      "4" => ["grandfather", "grandmother", "maternal-grandfather", "paternal-grandfather", "maternal-grandmother", "paternal-grandmother"],
      "5" => ["grandson", "granddaughter"],
      "6" => ["son-in-law", "daughter-in-law"],
      "7" => ["father-in-law", "mother-in-law"],
      "8" => ["husband", "wife"],
      "9" => ["aunt", "uncle", "maternal-aunt", "paternal-aunt", "maternal-uncle", "paternal-uncle"],
      "10" => ["niece", "nephew"],
      "11" => ["cousin"],
      "12" => ["brother-in-law", "sister-in-law"]
    }
  attr_reader :parse_permission

  def parse(permissions_array)
    permissions_array.join(" ")
  end

  def relationships_permitted 
    PERMISSION_HASH.map { |key, value| value if permissions.match(/(?<![a-z]|\d)#{key}(?!\d)/) }.compact.flatten 
  end

  def people_permitted
    permission_str = permissions.split(" ")
    permission_str.select { |permission| permission.match(/(?<=[a-z])\d+/) }
  end

  def all_permitted_members
    without_owner =  self.owner.my_family_members.collect do |member|
                member.first_name if member.can_see?(self)
              end.compact
    (without_owner + [self.owner.first_name]).join(", ")
  end

  def get_people(permission_key)
    current_person.checkbox_hash[permission_key.to_i]
  end

  def get_relation(slug)
    current_person.checkbox_hash.detect {|k, v| v.include?(slug)}[0]
  end
end