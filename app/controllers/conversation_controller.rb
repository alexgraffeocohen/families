class ConversationController < ApplicationController
  def index
    @conversations = all_conversations
    @conversation = new_conversation
  end

  def create
    @family = get_id_from_slug(params[:id])
    @conversation = Conversation.create(conversation_params)
  end

  def destroy
  end

  private

  def conversation_params
    params.require(:conversation).permit(:title)
  end
end
