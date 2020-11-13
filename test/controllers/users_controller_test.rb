require "test_helper"

describe UsersController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  it "can get the login form" do
    get login_path

    must_respond_with :success
  end

  describe "logging in" do
    it "can login a new user" do
      user = nil

      expect {
        user = login()
      }.must_differ "User.count", 1

      must_respond_with :redirect

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal "George Yu"
    end

    it "can login an existing user" do
      user = User.create(username: "Bobbee Fulter")

      # if user exist, should not create a new user
      expect {
        login(user.username)
      }.wont_change "User.count"

      expect(flash[:success]).wont_be_nil
      expect(session[:user_id]).must_equal user.id
    end

    it "cannot login user if username is nil" do

      expect {
        login(nil)
      }.wont_change "User.count"

      expect(flash[:error]).wont_be_nil
      must_respond_with :bad_request


    end
  end

  describe "logout" do
    it "can logout a logged in user" do
      login()
      expect(session[:user_id]).wont_be_nil

      post logout_path

      must_respond_with :redirect
      expect(flash[:success]).wont_be_nil
      expect(session[:user_id]).must_be_nil
    end
  end

end
