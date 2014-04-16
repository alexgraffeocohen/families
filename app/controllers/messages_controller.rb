class MessagesController < ApplicationController
  before_action :set_family
  before_action :set_conversation

  def create
    @message = Message.create(message_params)
    @message.conversation_id = params[:conversation_id]
    @message.sender = current_person
    @message.save
  end

  def destroy
    @message = Message.find(params[:message_id])
    respond_to do |f|
      if current_person == @message.sender
        @message.destroy
        f.html {redirect_to family_conversation_messages_path}
        f.js {render 'destroy'}
      else
        @msg = "Sorry, something went wrong."
        f.js {render 'destroy_failure', locals: {msge: @msg}}
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
