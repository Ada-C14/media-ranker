require "test_helper"

describe UsersController do

  describe "index" do
    it "it can get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do

  end
end
