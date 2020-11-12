require "test_helper"

describe HomepagesController do
  describe "root" do
    it "can get the root path" do
      get root_url
      must_respond_with :success
    end
  end

  describe "index" do

  end
end
