require 'spec_helper'

describe Conversation do
  before do
    @family       = create(:family)
    @message      = create(:message)
    @message2     = create(:message)
    @message2.sender = create(:person, first_name: "Alex")
    @conversation = build(:conversation, title: "title")
    @conversation.save(:validate => false)
    
    @family.conversations << @conversation
    @conversation.messages << @message
    @conversation.messages << @message2
  end

  it "has many messages" do
    expect(@conversation.messages.length).to eq(2)
  end

  it "belongs to a family" do
    expect(@family.conversations.length).to eq(1)
  end

  it "has a title" do
    expect(@conversation.title).to eq("Title")
  end

  it "can show last contributor" do
    expect(@conversation.last_contributor).to eq("Alex")
  end

  it "can show last message sent" do
    expect(@conversation.last_message).to eq(@message2.content)
  end

  it "can capitalize title" do
    @conversation = build(:conversation, title: "lowercase title")
    @conversation.save(:validate => false)

    expect(@conversation.title).to eq("Lowercase Title")
  end
end
