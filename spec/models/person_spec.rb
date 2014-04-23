require 'spec_helper'

describe Person do
  before(:each) do
    make_brady_bunch
  end

  it "gets a last name by default" do
    expect(@carol.last_name).to eq(@brady.name)
  end

  it "can have a separate last name" do
    expect(@connie.last_name).to eq("Hutchins")
  end

  it "can mutually assign spouses" do
    @carol.add_spouse(@mike)
    expect(@carol.spouse).to eq(@mike)
    expect(@mike.spouse).to eq(@carol)
  end
  
  it "can belong to a family" do 
    expect(@mike.default_family).to eq(@brady)
  end

  it "can return current relationships" do
    relations = ["brother", "sister", "brother", "brother", "sister", "mother", "father", "maternal-grandmother", "maternal-grandfather", "maternal-aunt", "maternal-uncle", "cousin", "paternal-grandfather", "paternal-aunt", "paternal-grandmother", "paternal-uncle"]
    expect(@marcia.current_relationships - relations).to be_empty
  end
end
