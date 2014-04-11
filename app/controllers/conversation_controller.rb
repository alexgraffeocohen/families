class ConversationController < ApplicationController
  def index
    @conversations = Conversation.all
  end

  def create
  end

  def destroy
  end
end
