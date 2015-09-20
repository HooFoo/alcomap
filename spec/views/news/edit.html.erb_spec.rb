require 'spec_helper'

describe "news/edit" do
  before(:each) do
    @news = assign(:news, stub_model(News,
                                     :user => nil,
                                     :point => nil
                        ))
  end

  it "renders the edit news form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", news_path(@news), "post" do
      assert_select "input#news_user[name=?]", "news[user]"
      assert_select "input#news_point[name=?]", "news[point]"
    end
  end
end
