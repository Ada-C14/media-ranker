require "test_helper"

describe UsersController do
  let (:anon) {
    User.create(username: "anonymous")
  }

  describe "login_form" do
    it "can get the login form" do
      get login_path

      must_respond_with :success
    end
  end

  describe "login" do
    it "can log in a new user" do
      user = nil

      expect {
        user = perform_login
      }.must_change "User.count", 1

      must_respond_with :redirect
      must_redirect_to root_path

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal "beauttie"
    end

    it "can log in an existing user" do
      user = anon

      expect {
        perform_login(user.username)
      }.wont_change "User.count", 1

      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal "anonymous"
    end
  end

  describe "logout" do
    it "can log out a logged in user" do
      perform_login
      expect(session[:user_id]).wont_be_nil

      post logout_path
      expect(session[:user_id]).must_be_nil
    end
  end

  describe "index" do
    it "responds with success when there are many users saved" do
      anon
      expect(User.count).must_equal 1

      get users_path

      must_respond_with :success
    end

    it "responds with success when there are no users saved" do
      expect(User.count).must_equal 0

      get users_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing user" do
      get user_path(anon.id)

      must_respond_with :success
    end

    it "responds with redirect with an invalid work id" do
      get user_path(-1)

      must_respond_with :redirect
      must_redirect_to users_path
    end
  end
end
