require 'spec_helper'

describe "news/new" do
  before(:each) do
    assign(:news, stub_model(News,
                             :user => nil,
                             :point => nil
                ).as_new_record)
  end

  it "renders new news form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", news_index_path, "post" do
      assert_select "input#news_user[name=?]", "news[user]"
      assert_select "input#news_point[name=?]", "news[point]"
    end
  end
end
