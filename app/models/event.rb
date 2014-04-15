class Event < ActiveRecord::Base
  belongs_to :owner, class: Person, foreign_key: :person_id
  include Permissable

  validates_presence_of :start_date, :end_date, :permissions
end
