require 'spec_helper'

describe "media/show" do
  before(:each) do
    @medium = assign(:medium, stub_model(Medium,
      :comment => nil,
      :user => nil,
      :bin => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
