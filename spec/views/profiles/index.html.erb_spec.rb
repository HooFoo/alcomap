require 'spec_helper'

describe "profiles/index" do
  before(:each) do
    assign(:profiles, [
      stub_model(Profile,
        :age => 1,
        :sex => "Sex",
        :comment => "Comment",
        :user => nil
      ),
      stub_model(Profile,
        :age => 1,
        :sex => "Sex",
        :comment => "Comment",
        :user => nil
      )
    ])
  end

  it "renders a list of profiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Sex".to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
