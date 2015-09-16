require 'spec_helper'

describe "settings/new" do
  before(:each) do
    assign(:setting, stub_model(Setting,
                                :json => "MyString",
                                :User => nil
                   ).as_new_record)
  end

  it "renders new setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", settings_path, "post" do
      assert_select "input#setting_json[name=?]", "setting[json]"
      assert_select "input#setting_User[name=?]", "setting[User]"
    end
  end
end
