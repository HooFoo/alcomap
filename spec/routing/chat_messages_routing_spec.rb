require "spec_helper"

describe ChatMessagesController do
  describe "routing" do

    it "routes to #index" do
      get("/chat_messages").should route_to("chat_messages#index")
    end

    it "routes to #new" do
      get("/chat_messages/new").should route_to("chat_messages#new")
    end

    it "routes to #show" do
      get("/chat_messages/1").should route_to("chat_messages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/chat_messages/1/edit").should route_to("chat_messages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/chat_messages").should route_to("chat_messages#create")
    end

    it "routes to #update" do
      put("/chat_messages/1").should route_to("chat_messages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/chat_messages/1").should route_to("chat_messages#destroy", :id => "1")
    end

  end
end
