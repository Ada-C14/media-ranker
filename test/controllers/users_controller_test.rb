require "test_helper"

describe UsersController do
  before do
    @user = User.create username:'test'
  end

  describe "index" do
    it "responds with success when there are many users saved" do
      # Arrange
      # Ensure that there is at least one work saved

      # Act
      get users_path

      # Assert
      must_respond_with :success

    end

    it "responds with success when there are no users saved" do
      # Arrange
      # Ensure that there are zero works saved
      @user.destroy

      # Act
      get users_path

      # Assert
      must_respond_with :success

    end
  end

  describe "show" do
    it "responds with success when showing an existing valid user" do
      # Arrange
      # Ensure that there is a work saved

      # Act
      get user_path(@user.id)

      # Assert
      must_respond_with :success

    end

    it "responds with 404 with an invalid user id" do
      # Arrange
      # Ensure that there is an id that points to no work

      get user_path(-1)

      # Assert
      must_respond_with :redirect

    end
  end

  it 'can get the login form' do
    get login_path

    must_respond_with :success
  end

  describe 'logging in' do
    it 'can login a new user' do
      user = nil
      expect {
        login()
      }.must_differ 'User.count', 1

      must_respond_with :redirect


      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal user_hash[:user][:username]
    end

    it 'can login an existing user' do
      user = User.create(username: 'Fred Flintstone')

      expect {
        login(user.username)
      }.wont_change 'User.count'

      expect(session[:user_id]).must_equal user.id
    end
  end

  describe 'logout' do
    it 'can logout a logged in user' do
      login()
      expect(session[:user_id]).wont_be_nil

      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end
end
