require "test_helper"

describe UsersController do

  describe "logging in" do
    before do
      @user = users(:testuser)
    end

    it "can get the login form" do
      get login_path

      must_respond_with :success
    end

    it "can create session for existing user" do
      perform_login(@user)
      expect(session[:user_id]).must_equal @user.id
    end

    it "can create session for a new user" do

      login_data = {
          user: {
              username: "new_user",
          },
      }

      expect{post login_path, params: login_data}.must_differ "User.count", 1
      expect(session[:user_id]).must_equal User.last.id
    end
  end

  describe "logging out" do
    before do
      @user = users(:testuser)
    end

    it "can log a user out" do
      perform_login
      expect(session[:user_id]).wont_be_nil

      post logout_path
      expect(session[:user_id]).must_be_nil
      must_respond_with :redirect
    end
  end
end

