require 'spec_helper'

describe Message do
  before do
    @message      = create(:message)
    @message2     = create(:message)
    @conversation = create(:conversation)
    
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
end
