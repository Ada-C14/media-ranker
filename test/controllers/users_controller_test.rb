require "test_helper"

describe UsersController do
  describe 'index' do
    it 'get index' do
      get users_path
      must_respond_with :success
    end
  end

  describe 'show' do
    before do
      @user = User.create(username: "test name")
    end

    it 'will get show for valid ids' do


      get user_path(@user.id)

      must_respond_with :success
    end

    it 'will respond with not found for invalid user ids' do
      get user_path(-1)

      must_respond_with :not_found
    end
  end

  describe "login_form" do
    it "responds with success" do
      # Act
      get login_path

      # Assert
      must_respond_with :success
    end
  end

  describe "log in" do
    before do

      @login_data = {user: {username: "test"}}

      @null_data = {user: {username: nil}
      }
    end

    it "can log in a new user" do

      expect{
        post login_path, params: @login_data
      }.must_change "User.count", 1

      user = User.find_by(username: "test")

      # verify user is in session
      expect(session[:user_id]).must_equal user.id

    end

    it "can log in an existing user" do
      User.create(username: "test")

      expect{
        post login_path, params: @login_data
      }.wont_change "User.count"

      user = User.find_by(username: "test")

      # verify user is in session
      expect(session[:user_id]).must_equal user.id
    end
  end

  describe 'log out' do
    before do

      @login_data = {user: {username: "test"}}

      @null_data = {user: {username: nil}
      }
    end
    it 'can log out a user currently in session' do
      post login_path, params: @login_data

      expect{
        post logout_path, params: @login_data
      }.wont_change "User.count"

      assert_nil(session[:user_id])

    end
  end

  describe "current" do
    # it "returns 200 OK for a logged-in user" do
    #   # Arrange
    #   perform_login
    #
    #   # Act
    #   get current_user_path
    #
    #   # Assert
    #   must_respond_with :success
    # end
  end




end
