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
      "1" => ["brother", "sister"],
      "2" => ["mother", "father"],
      "3" => ["son", "daughter"],
      "4" => ["grandfather", "grandmother"],
      "5" => ["grandson", "granddaughter"],
      "6" => ["son_in_law", "daughter_in_law"],
      "7" => ["husband", "wife"]
    }
    
    permission_hash.map { |key, value| value if permissions.include?(key.to_s) }.compact.flatten
  end

  def names_permitted
    album_permission = permissions.split(" ")
    album_permission.select {|permission| permission.match(/[A-Za-z]/)}
  end
end
