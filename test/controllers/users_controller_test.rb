require "test_helper"

describe UsersController do
  describe "index" do
    it "responds with success when there are many users saved" do
      # Arrange
      User.create username: "chao in space"
      # Act
      get users_path
      # Assert
      must_respond_with :success
    end

    it "responds with success when there are no users saved" do
      # Arrange
      # Ensure that there are zero drivers saved

      # Act
      get users_path
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    # Arrange
    before do
      User.create(username: "MrSnoozeboi34")
    end
    it "responds with success when showing an existing valid work" do
      # Arrange
      id = User.find_by(username:"MrSnoozeboi34")[:id]

      # Act
      get user_path(id)

      # Assert
      must_respond_with :success

    end

    it "responds with 404 with an invalid user id" do
      # Act
      get work_path(-1)
      # Assert
      must_respond_with :not_found
    end
  end
  describe "session functions " do
    before do
      # login data
      @login_data = {user: {username: "test"}}

      @null_data = {user: {username: nil}
      }
    end

    describe "login_form" do
      it "responds with success" do
        # Act
        get login_path

        # Assert
        must_respond_with :success
      end
    end

    describe "login" do
      it "creates a new user if logging in for the first time" do

        expect{
          post login_path, params: @login_data
        }.must_change "User.count", 1

        user = User.find_by(username: "test")

        # verify user is in session
        expect(session[:user_id]).must_equal user.id

      end

      it "logs in an existing user if username matches" do
        User.create(username: "test")

        expect{
          post login_path, params: @login_data
        }.wont_change "User.count"

        user = User.find_by(username: "test")

        # verify user is in session
        expect(session[:user_id]).must_equal user.id
      end

      it "renders login page with bad request if blank is attempted" do
         expect{
         post login_path, params: @null_data
         }.wont_change "User.count"

        assert_response :bad_request
      end
    end

    describe "logout" do
      it "logs out a user currently in session" do
        post login_path, params: @login_data

        expect{
          post logout_path, params: @login_data
        }.wont_change "User.count"

        assert_nil(session[:user_id])
      end
    end

  end

end
