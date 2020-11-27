require "test_helper"

describe UsersController do
  it "must get index" do
    get "/users"
    must_respond_with :success
  end

  it "can get the login form" do
    get "/login"
    must_respond_with :success
  end

  describe "logging in " do

    it "can login a new user" do
      user = nil
      expect {
        # Act
        user = login() # this helper method is in test_helper
      }.must_differ "User.count", 1

      must_respond_with :redirect
      
      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
    end

    it "can login an existing user" do
      user = User.create!(name: "Ed Sheeran")
      expect{
        login(user.name)
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.id
    end

  end

  describe "logout" do
    it "can logout a logged in user" do
      # Arrange 
      login()
      expect(session[:user_id]).wont_be_nil

      # Act
      post logout_path

      # Assertion
      expect(session[:user_id]).must_be_nil
    end

  end


end
