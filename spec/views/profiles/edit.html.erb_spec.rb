require 'spec_helper'

describe "profiles/edit" do
  before(:each) do
    @profile = assign(:profile, stub_model(Profile,
      :age => 1,
      :sex => "MyString",
      :comment => "MyString",
      :user => nil
    ))
  end

  it "renders the edit profile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", profile_path(@profile), "post" do
      assert_select "input#profile_age[name=?]", "profile[age]"
      assert_select "input#profile_sex[name=?]", "profile[sex]"
      assert_select "input#profile_comment[name=?]", "profile[comment]"
      assert_select "input#profile_user[name=?]", "profile[user]"
    end
  end
end
