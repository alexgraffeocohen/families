class MessagesController < ApplicationController
  before_action :set_family
  before_action :set_conversation

  def create
    @message = Message.create(message_params)
    @message.conversation_id = params[:conversation_id]
    @message.owner = current_person
    @message.save
  end

  def destroy
    @message = Message.find(params[:message_id])
    destroy_response(@message)
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
