class ConversationsController < ApplicationController
  before_action :set_family

  def index
    @conversations = Conversation.all_conversations
    @conversation = Conversation.new_conversation
  end

  def create
    @conversation = Conversation.create(conversation_params)
    @conversation.family_id = @family.id
    @conversation.save
  end

  def destroy
  end

  private

  def set_family
    @family = find_family(params[:id])
  end

  def conversation_params
    params.require(:conversation).permit(:title)
  end
end
