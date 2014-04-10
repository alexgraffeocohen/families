class Album < ActiveRecord::Base
  belongs_to :family
  belongs_to :owner, class_name: Person, foreign_key: :person_id
  has_many :photos

  validates_presence_of :name, :permissions

  attr_reader :parse_permission

  def parse_permission(permissions_array)
    permissions_array.join(" ")
  end

  def relationships_permitted
    album_permission = permissions.split(" ")
    
    permission_hash = {
      "1" => ["brother", "sister"],
      "2" => ["mother", "father"],
      "3" => ["son", "daughter"],
      "4" => ["grandmother", "grandfather"],
      "5" => ["granddaughter", "grandson"],
      "6" => ["son-in-law", "daughter-in-law"]
    }
    
    permission_hash.map { |key, value| value if permissions.include?(key.to_s) }.compact.flatten
  end
end
