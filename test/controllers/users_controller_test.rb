require "test_helper"

describe UsersController do
  it "can get the login form" do
    # Act
    get login_path

    must_respond_with :success
  end

  describe "logging in" do
    it "can login a new user" do
      # Arrange
      # Arrange
      user = User.first
      login_data = {
          user: {
              username: user.name
          }
      }

      # Act
      post login_path, params: login_data

      must_respond_with :redirect

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id #session variable will be set to the current user id. controller will be able to keep track of details for that current user via session user_id
      expect(user.name).must_equal "churro"
    end

    it "can login an existing user" do
      # Arrange
      user = User.first
      login_data = {
          user: {
              username: user.name
          }
      }

      # Act
      post login_path, params: login_data

      expect(session[:user_id]).must_equal user.id #checking that session id is set to user id again
    end
  end

  describe "log out" do
    it "can log out a logged in user" do
      # Arrange
      user = User.first
      login_data = {
          user: {
              username: user.name
          }
      }
      post login_path, params: login_data

      expect(session[:user_id]).wont_be_nil
      #Act
      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end

  describe "current user" do
    it "can return the page if the user is logged in" do
      #Arrange
      user = User.first
      login_data = {
          user: {
              username: user.name
          }
      }
      post login_path, params: login_data

      #Act
      get current_user_path
      #Assert
      must_respond_with :success
    end

    it "redirects the user if they are not logged in" do
      #Act
      get current_user_path
      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "You must be logged in to view this page"
    end
  end

  it "returns 200 OK for a logged-in user" do
    # Arrange
    perform_login
    # Act
    get current_user_path
    # Assert
    must_respond_with :success
  end
end
