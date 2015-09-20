require 'spec_helper'

describe "news/index" do
  before(:each) do
    assign(:news, [
                    stub_model(News,
                               :user => nil,
                               :point => nil
                    ),
                    stub_model(News,
                               :user => nil,
                               :point => nil
                    )
                ])
  end

  it "renders a list of news" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
