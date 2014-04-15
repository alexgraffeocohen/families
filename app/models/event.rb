class Event < ActiveRecord::Base
  belongs_to :owner, class: Person, foreign_key: :person_id
  include Permissable
end
