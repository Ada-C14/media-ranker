require "test_helper"

describe UsersController do
  it "can get the login form" do
    get login_path

    must_respond_with :success
  end

  describe "logging in" do
    it "can login a new user" do
      # scope: need to declare user outside expect block so it exists in rest of it block
      user = nil

      expect {
        # set user = to whatever login method returns
        user = login()
      }.must_differ "User.count", 1 # should increase by 1 b/c it's Grace's 1st visit

      # need to send them somewhere after logging in
      must_respond_with :redirect

      # expect user to exist
      expect(user).wont_be_nil

      # expect session to keep track of who user is --> session variable is set properly (to current user's id)
      # this way, every subsequent request the browser makes: send session variable w/ it so controller actions can track user
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal "Grace Hopper"
    end

    it "can login an existing user" do
      user = User.create(username: "Ted Sharon")

      # if user already exists, logging in won't create a new user and two users won't have same username
      expect {
        login(user.username)
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.id
    end
  end

  describe "logout" do
    it "can logout a logged in user" do
      # arrange
      login()
      expect(session[:user_id]).wont_be_nil

      # act
      # no method body since we're not submitting form
      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end

  describe "current user" do
    it "can return the page if user is logged in" do
      # arrange
      login()

      # act
      get current_user_path

      # assert
      must_respond_with :success
    end

    it "redirects us back if the user is not logged in" do
      # no arrange step
      # not logged in

      # act
      get current_user_path

      # assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "You must be logged in to view this page"

    end
  end

end
