require 'spec_helper'

describe "media/new" do
  before(:each) do
    assign(:medium, stub_model(Medium,
      :comment => nil,
      :user => nil,
      :bin => ""
    ).as_new_record)
  end

  it "renders new medium form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", media_path, "post" do
      assert_select "input#medium_comment[name=?]", "medium[comment]"
      assert_select "input#medium_user[name=?]", "medium[user]"
      assert_select "input#medium_bin[name=?]", "medium[bin]"
    end
  end
end
