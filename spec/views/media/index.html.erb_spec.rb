require 'spec_helper'

describe "media/index" do
  before(:each) do
    assign(:media, [
      stub_model(Medium,
        :comment => nil,
        :user => nil,
        :bin => ""
      ),
      stub_model(Medium,
        :comment => nil,
        :user => nil,
        :bin => ""
      )
    ])
  end

  it "renders a list of media" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
