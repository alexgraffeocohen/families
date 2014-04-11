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
    @message = Message.find(params[:message_id])
    respond_to do |f|
      if current_person == @message.person
        @message.destroy
        f.html {redirect_to family_conversation_messages_index_path}
        f.js {render 'destroy'}
      else
        @msg = "Sorry, you do not own this album."
        f.js {render 'destroy_failure', locals: {msge: @msg}}
      end
    end
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
