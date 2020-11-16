require "test_helper"

describe HomepagesController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  #
  describe 'index' do
    it "must get index" do
      get root_path
      must_respond_with :success
    end
  end
end
