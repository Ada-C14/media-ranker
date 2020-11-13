require "test_helper"

describe UsersController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  it "can get the login form" do # PASSING TEST
    get login_path

    must_respond_with :success
  end

  describe "logging in" do

    it "can login a new user" do
      #Arrange  -> form data that will be submitted
      user_hash = {
          user: {
              username: "Grace Hopper"
          }
      }
      #Act Post request to this path with those params and user will increase by 1

      expect {
        post login_path, params: user_hash
      }.must_change "User.count", 1
      #This will redirect

      must_respond_with :redirect
      user = User.find_by[username: user_hash[:user][:username]]

      #expect user exist and session will be set to current users id
      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal user_hash[:user][:username]
    end

    it "can login an existing user" do # PASSING TEST
      user = User.create(username: "Ed Sheeran ")

      expect{
        login(user.username)
      }.wont_change "User.count"

    expect(session[:user_id]).must_equal user.id
    end
  end
end
