require 'spec_helper'

describe "media/edit" do
  before(:each) do
    @medium = assign(:medium, stub_model(Medium,
      :comment => nil,
      :user => nil,
      :bin => ""
    ))
  end

  it "renders the edit medium form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", medium_path(@medium), "post" do
      assert_select "input#medium_comment[name=?]", "medium[comment]"
      assert_select "input#medium_user[name=?]", "medium[user]"
      assert_select "input#medium_bin[name=?]", "medium[bin]"
    end
  end
end
