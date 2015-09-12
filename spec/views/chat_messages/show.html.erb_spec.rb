require 'spec_helper'

describe "chat_messages/show" do
  before(:each) do
    @chat_message = assign(:chat_message, stub_model(ChatMessage))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
