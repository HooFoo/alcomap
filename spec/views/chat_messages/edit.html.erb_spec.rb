require 'spec_helper'

describe "chat_messages/edit" do
  before(:each) do
    @chat_message = assign(:chat_message, stub_model(ChatMessage))
  end

  it "renders the edit chat_message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", chat_message_path(@chat_message), "post" do
    end
  end
end
