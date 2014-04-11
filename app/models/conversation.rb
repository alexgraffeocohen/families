class Conversation < ActiveRecord::Base
  belongs_to :family
  has_many :messages

  scope :all_conversations, -> {all}
  scope :new_conversation, -> {new}
end
