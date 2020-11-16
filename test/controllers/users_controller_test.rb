require "test_helper"

describe UsersController do
  let(:new_user) {
    User.new(username: "test user")
  }

  it "must get index" do
    # Arrange
    new_user.save

    # Act
    get user_path(new_user.id)

    # Assert
    must_respond_with :success
  end

  it "must get show" do
    # Act
    get users_path

    # Assert
    must_respond_with :success
  end

  it "returns not found when the user does not exist" do
    # Act
    get user_path(-1)

    # Assert
    must_respond_with :not_found
  end

  describe "login form" do
    it "can get the log in form" do
      # Act
      get login_path

      # Assert
      must_respond_with :success
    end
  end

  describe "login" do
    it "can log in an existing user and redirect to the root path" do
      # Arrange
      new_user.save
      # login_data = {
      #     user: {
      #         username: new_user.username
      #     }
      # }
      #
      # # Act
      # post login_path, params: login_data

      # Act
      expect{
        perform_login(new_user)
      }.wont_differ "User.count"

      # Assert
      expect(new_user).wont_be_nil
      expect(session[:user_id]).must_equal new_user.id
      expect(flash[:success]).must_equal "Successfully logged in as existing user test user"
      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "can log in a new user and redirect to the root path" do
      # Act/Assert
      user = nil

      expect {
        perform_login(user)
      }.must_differ "User.count", 1

      expect(user).wont_be_nil
      # expect(session[:user_id]).must_equal user.id
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
    # it "can log in a user and redirect to the root path" do
    #   # Arrange
    #   new_user.save
    #
    #
    #   perform_login(new_user)
    #
    #   # Assert
    #   expect(new_user).wont_be_nil
    #   expect(session[:user_id]).must_equal new_user.id
    #   must_respond_with :redirect
    #   must_redirect_to root_path
    # end

  describe "current" do
    it "returns 200 OK for a logged-in user" do
      # Arrange
      new_user.save
      perform_login(new_user)

      # Act
      get current_user_path

      # Assert
      must_respond_with :success
    end

    it "creates a flash message and redirects to the root path if the user is not logged in" do
      # Act
      get current_user_path

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "You must be logged in to see this page"
    end
  end

  describe "logout" do
    it "logs out the user and redirects to the root path" do
      # Arrange
      new_user.save

      # Act
      post logout_path

      # Assert
      expect(session[:user_id]).must_be_nil
      expect(flash[:success]).must_equal "Successfully logged out"
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
end

