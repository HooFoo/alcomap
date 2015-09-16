require 'spec_helper'

describe "settings/index" do
  before(:each) do
    assign(:settings, [
                        stub_model(Setting,
                                   :json => "Json",
                                   :User => nil
                        ),
                        stub_model(Setting,
                                   :json => "Json",
                                   :User => nil
                        )
                    ])
  end

  it "renders a list of settings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Json".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
