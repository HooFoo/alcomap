require 'spec_helper'

describe "points/new" do
  before(:each) do
    assign(:point, stub_model(Point,
      :coords => "MyString",
      :name => "MyString",
      :description => "MyString",
      :user => nil
    ).as_new_record)
  end

  it "renders new point form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", points_path, "post" do
      assert_select "input#point_coords[name=?]", "point[coords]"
      assert_select "input#point_name[name=?]", "point[name]"
      assert_select "input#point_description[name=?]", "point[description]"
      assert_select "input#point_user[name=?]", "point[user]"
    end
  end
end
