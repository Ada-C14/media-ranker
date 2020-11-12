require "test_helper"

describe UsersController do

  describe "index" do
    it "can get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "can go to show page" do

      get user_path(users(:harry))
      must_respond_with :success
    end

    it "will respond with not found for invalid id" do
      get user_path(-1)
      must_respond_with :not_found
    end
  end

  # describe "current" do
  #   it "returns 200 OK for a logged-in user" do
  #     # Arrange
  #     perform_login
  #     # Act
  #     get current_user_path
  #
  #     # Assert
  #     must_respond_with :success
  #   end
  # end

  describe "login form" do
    it "can get to the login form" do
      get login_path
      must_respond_with :success
    end
  end

  describe "login" do
    it "logs in a new user" do
      new_user = User.create!(username: "Jasmine")
      expect(perform_login(new_user)).must_equal new_user
    end

    it "logs in a returning user" do
      returning_user = perform_login
      expect(User.find_by(id: returning_user.id)).wont_be_nil
    end
  end

  describe "logout" do
    it "successfully logs a user out" do
      perform_login
      post logout_path
      must_respond_with :redirect
      expect(session[:user_id]).must_be_nil
    end
  end
end
