class MessagesController < ApplicationController

  before_action :set_arrangements

  def index
    @message = Message.new
  end

  def create
    @message = Message.create(message_params)
    @message.conversation_id = params[:conversation_id]
    @message.person = current_person
    @message.save
  end

  def destroy
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_arrangements
    @conversation = Conversation.find(params[:conversation_id])
    @family = find_family(params[:id])
  end
end
