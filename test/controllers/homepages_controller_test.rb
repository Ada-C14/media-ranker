require "test_helper"

describe HomepagesController do
  describe "index" do
    it "successfully navigates to root_path" do
      get root_path
      must_respond_with :success
    end

    it "successfully loads root path even if there are no works" do
      works(:hp1).delete
      expect(Work.count).must_equal 0
      get root_path
      must_respond_with :success
    end
  end
end
