class ConversationsController < ApplicationController
  before_action :set_family
  before_action :set_conversation, :only => [:show, :destroy]
  before_action :prepare_search_form, :only => [:index]
  before_action :only => [:index] do
    provide_relationships(@family)
  end

  def index
    @conversation = Conversation.new_conversation
    @permitted_conversations = current_person.all_permitted("conversation")
  end

  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.permissions = @conversation.parse(params[:conversation][:parse_permission])
    @conversation.family_id = @family.id
    @conversation.person_id = current_person.id
    @conversation.save

    
    respond_to do |f|
      if @conversation.save
        f.js {render 'create', locals: {conversation: @conversation}}
        f.html {redirect_to :back}
      else
        @msg = print_errors_for(@conversation)
        f.js {render 'layouts/create_failure', locals: {msge: @msg}}
      end 
    end
  end

  def show
    @message = Message.new
  end

  def destroy
    destroy_response(@conversation)
  end

  def check_messages
    @new_messages = Message.where("conversation_id = ? and created_at > ?", params[:conversation_id], Time.at(params[:after].to_i + 1))
  end

  private

  def prepare_search_form
    @conversations = Conversation.all_conversations
    @search = Conversation.search(params[:q])

    render_search_results
  end

  def render_search_results
    @not_found_ids =  (@conversations - @search.result).collect do |conversation|
                        conversation.id
                      end
                      
    if params[:q] != nil
      respond_to do |f|
        f.html {head :ok}
        f.js {render 'search_success', locals: {unfound: @not_found_ids}}
      end
    end
  end

  def conversation_params
    params.require(:conversation).permit(:title)
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
