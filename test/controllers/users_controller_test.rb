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
    before do
      @user = User.create(username: "squash")
    end
    it "can get the login form" do
      get "/login"

      must_respond_with :success
    end

    it "can successfully login a new user" do
      new_user = {
        user: {
            username: "test user"
        }
      }

      expect {
        post login_path, params: new_user
      }.must_differ "User.count", 1

      must_redirect_to root_path

      user = User.find_by(username: new_user[:user][:username])

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
    end

    it "can login an existing user" do
      session[:user_id] = nil

      expect {
        post login_path, params: @user.username
      }.wont_change "User.count"

      session[:user_id] = @user.id
      p session[:user_id]

      expect(@user).wont_be_nil
      expect(session[:user_id]).must_equal @user.id
    end
  end

  describe "logout" do
    it "can logout a user" do

    end
  end

  describe "current_user" do

  end
end
