class ConversationsController < ApplicationController
  before_action :set_family

  def index
    @conversations = Conversation.all_conversations
    @conversation = Conversation.new_conversation
    @permitted_conversations = current_person.all_permitted("conversation")
    
    @other_members = @family.people.to_a.delete_if {|i| i == current_person}
    @relationships = Person::GROUP_RELATIONSHIPS

    @search = Conversation.search(params[:q])
    @all_found = @search.result
    @not_found = @conversations - @all_found
    @not_found_ids =  @not_found.collect do |conversation|
                    conversation.id
                  end
    if params[:show_all] != nil
      respond_to do |f|
        f.html {head :ok}
        f.js {render 'show_all'}    
      end
    elsif params[:q] != nil
      respond_to do |f|
        f.html {head :ok}
        f.js {render 'search_success', locals: {unfound: @not_found_ids}}
      end
    end
  end

  def create
    @conversation = Conversation.create(conversation_params)
    unless params[:conversation][:parse_permission].blank?
      @conversation.permissions = @conversation.parse(params[:conversation][:parse_permission])
    end
    if @conversation.save
      @conversation.family_id = @family.id
      @conversation.person_id = current_person.id
      redirect_to family_conversations_path(@family)
    else
      flash[:alert] = "Please enter title and permissions."
      redirect_to :back
    end
  end

  def destroy
    @conversation = Conversation.find(params[:conversation_id])
    respond_to do |f|
      if current_person.admin == 1
        @conversation.destroy
        f.html {redirect_to family_conversations_path}
        f.js {render 'destroy'}
      else
        @msg = "Sorry, you are not a family admin."
        f.js {render 'destroy_failure', locals: {msge: @msg}}
      end
    end
  end

  private

  def set_family
    @family = find_family(params[:id])
  end

  def conversation_params
    params.require(:conversation).permit(:title)
  end
end
