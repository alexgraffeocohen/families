require 'spec_helper'

describe Message do
  before do
    @message      = create(:message)
    @conversation = create(:conversation)
    @person       = create(:person)

    @message.sender = @person
    @conversation.messages << @message
  end

  it "belongs to a conversation" do
    expect(@message.conversation).to eq(@conversation)
  end

  it "has content" do
    expect(@message.content).to eq("MyText")
  end

  it "belongs to a person" do
    expect(@message.sender).to eq(@person)
  end
end
