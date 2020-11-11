require "test_helper"

describe UsersController do
  describe "index" do
    it "responds with success when users are saved" do
      user = users()

      get users_path

      must_respond_with :success
    end

    it "responds with success when no users are saved" do
      User.destroy_all

      get users_path

      must_respond_with :success
    end
  end



end
