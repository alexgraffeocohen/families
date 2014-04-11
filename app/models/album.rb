class Album < ActiveRecord::Base
  belongs_to :family
  belongs_to :owner, class_name: Person, foreign_key: :person_id
  has_many   :photos

  validates_presence_of :name, :permissions

  attr_reader :parse_permission

  def parse(permissions_array)
    permissions_array.join(" ")
  end

  def relationships_permitted
    album_permission = permissions.split(" ")
    
    permission_hash = {
      "1" => "siblings",
      "2" => "parents",
      "3" => "children",
      "4" => "grandparents",
      "5" => "grandchildren",
      "6" => "children_in_laws",
      "7" => "spouse"
    }
    
    permission_hash.map { |key, value| value if permissions.include?(key.to_s) }.compact.flatten
  end
end
