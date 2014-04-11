class ConversationController < ApplicationController
  def index
    @conversations = all_conversations
  end

  def create

  end

  def destroy
  end
end
