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
      expect {
        user = perform_login()
      }.must_differ "User.count", 1

      must_respond_with :redirect

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      # expect(user.username).must_equal @user_hash[:user][:username]
      expect(user.username).must_equal "Username 1"
    end

    it "can login an existing user" do
      user = User.create(username: "Username 2")

      expect {
        perform_login(user)
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.id
    end
  end

    describe "current" do
      it "returns 200 OK for a logged-in user" do
        # Arrange
        # perform_login
        perform_login
        # Act
        get current_user_path
        # Assert
        must_respond_with :success
      end
    end

    describe "logout" do
      it "can logout a logged in user" do
        perform_login()
        expect(session[:user_id]).wont_be_nil
        post logout_path
        expect(session[:user_id]).must_be_nil
      end
    end
  end
