require "test_helper"

describe HomepagesController do
  describe "index" do
    it "successfully navigates to index page" do
      get root_path
      must_respond_with :success
    end
  end
end
