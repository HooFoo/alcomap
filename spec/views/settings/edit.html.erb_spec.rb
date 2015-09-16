require 'spec_helper'

describe "settings/edit" do
  before(:each) do
    @setting = assign(:setting, stub_model(Setting,
                                           :json => "MyString",
                                           :User => nil
                              ))
  end

  it "renders the edit setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", setting_path(@setting), "post" do
      assert_select "input#setting_json[name=?]", "setting[json]"
      assert_select "input#setting_User[name=?]", "setting[User]"
    end
  end
end
