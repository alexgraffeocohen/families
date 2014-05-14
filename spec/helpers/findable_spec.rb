require 'spec_helper'

describe Findable do
  before(:each) do
    make_brady_bunch
  end

  it "can determine son" do
    expect(@greg.relationship_to(@carol)).to eq('son')
  end

  it "can determine daughter" do
    expect(@marcia.relationship_to(@carol)).to eq('daughter')
  end

  it "can determine sister" do
    expect(@marcia.relationship_to(@greg)).to eq('sister')
  end

  it "can determine brother" do
    expect(@greg.relationship_to(@marcia)).to eq('brother')
  end
  
  it "can determine grandson" do
    expect(@greg.relationship_to(@harold)).to eq('grandson')
  end

  it "can determine granddaughter" do
    expect(@marcia.relationship_to(@connie)).to eq('granddaughter')
  end

  it "can determine mother" do
    expect(@carol.relationship_to(@greg)).to eq('mother')
  end

  it "can determine father" do
    expect(@mike.relationship_to(@marcia)).to eq('father')
  end

  it "can determine paternal grandfather" do
    expect(@robert.relationship_to(@greg)).to eq('paternal-grandfather')
  end

  it "can determine maternal grandfather" do
    expect(@harold.relationship_to(@greg)).to eq('maternal-grandfather')
  end

  it "can determine maternal grandmother" do
    expect(@connie.relationship_to(@marcia)).to eq('maternal-grandmother')
  end

  it "can determine paternal grandmother" do
    expect(@rachel.relationship_to(@greg)).to eq('paternal-grandmother')
  end

  it "can determine wife" do
    expect(@carol.relationship_to(@mike)).to eq('wife')
  end

  it "can determine husband" do
    expect(@mike.relationship_to(@carol)).to eq('husband')
  end

  it "can determine son-in-law" do
    expect(@mike.relationship_to(@harold)).to eq('son-in-law')
  end

  it "can determine father-in-law" do
    expect(@harold.relationship_to(@mike)).to eq('father-in-law')
  end

  it "can determine maternal aunt" do
    expect(@jenny.relationship_to(@greg)).to eq('maternal-aunt')
  end

  it "can determine paternal aunt" do
    expect(@rebekah.relationship_to(@marcia)).to eq('paternal-aunt')
  end

  it "can determine maternal uncle" do
    expect(@jon.relationship_to(@marcia)).to eq('maternal-uncle')
  end

  it "can determine paternal uncle" do
    expect(@dan.relationship_to(@marcia)).to eq('paternal-uncle')
  end

  it "can determine brother-in-law" do
    expect(@mike.relationship_to(@jon)).to eq('brother-in-law')
  end

  it "can determine sister-in-law" do
    expect(@jenny.relationship_to(@mike)).to eq('sister-in-law')
    expect(@carol.relationship_to(@rebekah)).to eq('sister-in-law')
    expect(@rebekah.relationship_to(@carol)).to eq('sister-in-law')
  end

  it "can determine niece" do
    expect(@marcia.relationship_to(@jenny)).to eq('niece')
  end

  it "can determine nephew" do
    expect(@greg.relationship_to(@jon)).to eq('nephew')
  end

  it "can determin cousin" do
    expect(@greg.relationship_to(@jon_jr)).to eq('cousin')
  end

  it "can determine mother-in-law" do
    expect(@connie.relationship_to(@mike)).to eq('mother-in-law')
  end

  it "can determine daughter-in-law" do
    expect(@carol.relationship_to(@rachel)).to eq('daughter-in-law')
  end
end