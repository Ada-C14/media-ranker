require "test_helper"

describe UsersController do
  it "can get the login form" do
    get login_path

    must_respond_with :success
  end

  describe "logging in" do
    it "can login a new user" do
      # Arrange
      user = nil
      user_hash = {
          user: {
              name: "churro2021" #form data that will be submitted
          }
      }

      expect {
      # Act
      post login_path, params: user_hash  #sends post request to path with those params
      }.must_differ "User.count", 1 #successful login will increase user count by one

      must_respond_with :redirect
      user = User.find_by(name: user_hash[:user][:name])

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id #session variable will be set to the current user id. controller will be able to keep track of details for that current user via session user_id
      expect(user.name).must_equal user_hash[:user][:name]
    end

    # it "can login an existing user" do
    #   user = User.create(name: "churro2020")
    #
    #   expect {
    #     login(user.name)
    #   }.wont_change "User.count"
    #
    #   expect(session[:user_id]).must_equal user.id #checking that session id is set to user id again
    # end
  end
end
