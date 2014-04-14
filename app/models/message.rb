class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :sender, class_name: Person, foreign_key: :person_id
end
