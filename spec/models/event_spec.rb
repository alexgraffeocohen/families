require 'spec_helper'

describe Event do
  before(:each) do
    make_brady_bunch
    @event = build(:event)
    @event.permissions = "1 2"
    @event.owner = @greg
    @brady.events << @event
  end

  it "belongs to a person" do
    expect(@event.owner.first_name).to eq("Greg")
  end

  it "belongs to a family" do
    expect(@event.family).to eq(@brady)
  end

  it "can allow people to see it" do
    expect(@marcia.can_see?(@event)).to eq(true)
    expect(@mike.can_see?(@event)).to eq(true)
  end

  it "can prevent people from seeing it" do
    expect(@harold.can_see?(@event)).to eq(false)
    expect(@connie.can_see?(@event)).to eq(false)
  end
end
