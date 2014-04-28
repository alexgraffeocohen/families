class Conversation < ActiveRecord::Base
  include Permissable
  
  belongs_to :family
  belongs_to :owner, class_name: Person, foreign_key: :person_id
  has_many :messages, dependent: :destroy

  validates_presence_of :title, :permissions

  scope :all_conversations, -> {all}
  scope :new_conversation, -> {new}

  def last_contributor
    messages.last.owner.first_name
  end

  def last_message
    messages.last.content
  end
end
