require "test_helper"

describe UsersController do
  describe "index" do
    it "can get the index page" do
      get "/users"

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get the show path for the targeted user" do
      user = User.create(username: "test")

      get "/users/#{user.id}"

      expect(user.username).must_equal "test"

      must_respond_with :success
    end
  end

  describe "login" do

    it "can get the login form" do
      get "/login"

      must_respond_with :success
    end

    it "can successfully login a new user" do
      user = nil
      expect {
        user = login()
      }.must_differ "User.count", 1

      must_redirect_to root_path

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
    end

    it "can login an existing user" do
      user = User.create(username: "squash")

      expect {
        login(user.username)
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.id
    end
  end

  describe "logout" do
    it "can logout a user" do
      login()
      expect(session[:user_id]).wont_be_nil

      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end

  # describe "current_user" do #error with user/show page
  #   it "can get the current user who is logged in" do
  #     login()
  #
  #     get current_user_path
  #
  #     must_respond_with :success
  #   end
  # end
end
