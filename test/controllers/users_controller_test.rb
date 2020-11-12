require "test_helper"

describe UsersController do

  describe "logging in form" do
    it "can get the login form" do
      get login_path
      must_respond_with :success
    end
  end

  describe "logging in" do
    it "can login a new user" do
      user = nil
      expect{
        user = login()
      }.must_differ "User.count", 1

      must_respond_with :redirect

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal user_hash[:user][:username]
    end

    it "can login an exisiting user" do
      user = User.create(username: "Username 2")

      expect{
        login(user.username)
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.id
    end

  end


end
