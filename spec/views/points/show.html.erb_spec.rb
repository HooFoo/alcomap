require 'spec_helper'

describe "points/show" do
  before(:each) do
    @point = assign(:point, stub_model(Point,
      :coords => "Coords",
      :name => "Name",
      :description => "Description",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Coords/)
    rendered.should match(/Name/)
    rendered.should match(/Description/)
    rendered.should match(//)
  end
end
