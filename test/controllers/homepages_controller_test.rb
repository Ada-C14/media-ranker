require "test_helper"

describe HomepagesController do
  it "still loads the main page if there are no works" do
    get root_path
    must_respond_with :success
  end
end
