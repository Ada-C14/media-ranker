require "test_helper"

describe UsersController do

  before do
    User.create(username: "Alice")
  end

  it "can get the login_form" do
    get login_path

    must_respond_with :success
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
      expect(user.username).must_equal "Grace Hopper"
    end

    it "can login an existing user" do
      user = User.create(username: "Ed Sheeran")

      expect{
        login(user.username)
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

      expect(session[:user_id]).must_be_nil
    end
  end

  describe "current user" do
    it "can return the page if user is logged in" do
      # Arrange
      login()

      id = User.find_by(username:"Alice")[:id]

      #Act
      get user_path(id)

      #Assert
      must_respond_with :success
    end

    it "redirect us back if user is not logged in" do

      #Act
      get current_user_path

      #Assert
      must_respond_with :redirect
      expect(flash[:error] = "A problem occurred: You must log in to do that")
    end
  end
end

