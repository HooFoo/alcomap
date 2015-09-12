require 'spec_helper'

describe "chat_messages/index" do
  before(:each) do
    assign(:chat_messages, [
      stub_model(ChatMessage),
      stub_model(ChatMessage)
    ])
  end

  it "renders a list of chat_messages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
