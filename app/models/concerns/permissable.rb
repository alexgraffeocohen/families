module Permissable
  extend ActiveSupport::Concern

  attr_reader :parse_permission

  def parse(permissions_array)
    permissions_array.join(" ")
  end

  def relationships_permitted    
    permission_hash = {
      "1" => ["brother", "sister"],
      "2" => ["mother", "father"],
      "3" => ["son", "daughter"],
      "4" => ["grandfather", "grandmother"],
      "5" => ["grandson", "granddaughter"],
      "6" => ["son_in_law", "daughter_in_law"],
      "7" => ["husband", "wife"]
    }
    
    permission_hash.map { |key, value| value if permissions.include?(key) }.compact.flatten
  end

  def names_permitted
    permission_str = permissions.split(" ")
    permission_str.select {|permission| permission.match(/[A-Za-z]/)}
  end
end