class Conversation < ActiveRecord::Base
  belongs_to :family
  has_many :messages
end
