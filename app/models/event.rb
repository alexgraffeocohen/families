class Event < ActiveRecord::Base
  belongs_to :owner, class: Person, foreign_key: :person_id
  belongs_to :family
  include Permissable

  validates_presence_of :start_date, :end_date, :permissions

  def formatted_date
    [start_date.day, start_date.month]
  end
end
