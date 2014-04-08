class Album < ActiveRecord::Base
  belongs_to :family
  has_many :photos

  attr_accessor :owner
end
