class Conversation < ActiveRecord::Base
  belongs_to :family
  has_many :messages

  scope :all_conversations, -> {all}
  scope :new_conversation, -> {new}

  def last_contributor
    messages.last.sender.first_name
  end

  def last_message
    messages.last.content
  end
end
