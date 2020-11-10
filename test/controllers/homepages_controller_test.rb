require "test_helper"

describe HomepagesController do
   it "should get index" do
     get root_path
     assert_response :success
   end
end

