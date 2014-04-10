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
    permission = permissions.split(" ")
    members = []
    if permission.include?("1")
      members << ["brother", "sister"]
    elsif permission.include("2")
      members << ["mother", "father"]
    elsif permission.include("3")
      members << ["son", "daughter"]
    elsif permission.include("4")
      members << ["grandmother", "grandfather"]
    elsif permission.include("5")
      members << ["granddaughter", "grandson"]
    elsif permission.include("6")
      members << ["son-in-law", "daughter-in-law"]
    end
    members.flatten
  end
end
