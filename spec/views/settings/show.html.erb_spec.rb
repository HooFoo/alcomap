require 'spec_helper'

describe "settings/show" do
  before(:each) do
    @setting = assign(:setting, stub_model(Setting,
                                           :json => "Json",
                                           :User => nil
                              ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Json/)
    rendered.should match(//)
  end
end
