require "test_helper"

describe HomepagesController do
  describe "root" do
    it "can get the root path" do
      get root_url
      must_respond_with :success
    end
  end

  describe "index" do

    it "doesnt break when there are no works" do
      works(:test_work).destroy
      works(:second_test_work).destroy
      expect(Work.count).must_equal 0
      get root_url
      must_respond_with :success
    end

  end
end
