require 'spec_helper'

describe "profiles/show" do
  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :age => 1,
      :sex => "Sex",
      :comment => "Comment",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Sex/)
    rendered.should match(/Comment/)
    rendered.should match(//)
  end
end
