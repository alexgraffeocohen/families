require 'spec_helper'

describe Message do
  before do
    @message      = create(:message)
    @conversation = create(:conversation)
    @person       = create(:person)

    @message.person_id = @person.id
    @conversation.messages << @message
  end

  it "belongs to a conversation" do
    expect(@message.conversation).to eq(@conversation)
  end

  it "has content" do
    expect(@message.content).to eq("MyText")
  end

  it "belongs to a person" do
    expect(@message.person).to eq(@person)
  end
end
