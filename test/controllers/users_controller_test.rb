require "test_helper"

describe UsersController do
  it "must get login form" do
    get login_path
    must_respond_with :success
  end

  # it "must get login" do
  #   get users_login_url
  #   must_respond_with :success
  # end
  describe "logging in" do
    it "can login a new user" do
      user = nil
      expect{
        user = login()#set user equal to whatever user will return
      }.must_differ "User.count", 1

      #should give a redirect
      must_respond_with :redirect
      #lookup the user
      # user = User.find_by(name: user_hash[:user][:name])

      expect(user).wont_be_nil # expect that user exist
      expect(session[:user_id]).must_equal user.id #check if session has been set,
      # session variable is going to be set to the current users id
      expect(user.name).must_equal "Grace Hopper"
    end
    it "can login an existing user " do
      user = User.create(name: "Bruce Lee")

      expect{
          login(user.name)
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.id #check if session has been set,
      # session variable is going to be set to the current users id
    end
  end

  describe "logout" do
    it "can logout a logged in user" do
      #arrange
      login()
      expect(session[:user_id]).wont_be_nil
      #act
      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end

  describe "current user" do
    it "can return the page if the user us logged in" do
      #arrange
      login()
      #act
      get current_user_path
      # assert
      must_respond_with :success
    end

    it "redirect us back if the user is logged in" do
      #act
      get current_user_path

      #assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "You must be logged in to view this page"
    end

    it "returns 200 OK for a logged-in user" do
      # Arrange
      login

      # Act
      get current_user_path

      # Assert
      must_respond_with :success
    end
  end
end
