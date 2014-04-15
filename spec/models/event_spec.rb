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

end
