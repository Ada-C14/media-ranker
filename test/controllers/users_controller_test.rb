require "test_helper"

describe UsersController do
  it "must get login_form" do
    get login_path

    must_respond_with :success
  end

  describe "logging in" do
    it "can login a new user" do
      user_hash = {
          user: {
              username: "Gina Atto"
          }
      }

      expect{
        post login_path, params: user_hash
      }.must_differ "User.count", 1

      must_respond_with :redirect

    end
  end
end