class Album < ActiveRecord::Base
  include Permissable
  
  belongs_to :family
  belongs_to :owner, class_name: Person, foreign_key: :person_id
  has_many   :photos, dependent: :destroy 

  validates_presence_of :name, :permissions

  attr_reader :parse_permission

  def set_family(params)
    find_family(params[:id]).id
  end
end
