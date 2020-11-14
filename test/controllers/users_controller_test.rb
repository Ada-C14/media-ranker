require "test_helper"

describe UsersController do
  describe "login" do
    it "can get the login form" do
      get login_path

      must_respond_with :success
    end
  end

  describe "logging in" do
    it "can log a user in" do
      user = nil
      expect {
        user = login()
      }.must_change "User.count", 1

      must_respond_with :redirect

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal "Ada Lovelace"
    end

    it "can login an existing user" do
      user = User.create(username: "Hugo")

      expect {
        login(user.username)
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.id
    end
  end

  describe "logging out" do
    it "can log out a logged in user" do
      login()

      expect(session[:user_id]).wont_be_nil
      post logout_path

      expect(session[:user_id]).must_be_nil
    end

  #  it "can notify user if they can't log out" do
  #
  # end
  end

  describe "current user" do
    it "can return the page if the user is logged in" do
      login()

      get current_user_path

      must_respond_with :success
    end

    it "redirects user back if the user is not logged in" do
      get current_user_path

      must_respond_with :redirect
      expect(flash[:error]).must_equal "You must be logged in to view this page."
    end
  end
end
