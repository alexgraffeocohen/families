require 'spec_helper'

describe Message do
  before do
    @message      = create(:message)
    @conversation = build(:conversation)
    @person       = create(:person)

    @conversation.save(:validate => false)
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
