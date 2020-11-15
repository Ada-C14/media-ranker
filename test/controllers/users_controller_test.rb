require "test_helper"

describe UsersController do
  describe "index" do
    it "responds with success when there are many users saved" do
      User.create username: "Someone"
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    # Arrange
    before do
      User.create(username: "Anna")
    end
    it "responds with success when showing an existing valid work" do
      # Arrange
      id = User.find_by(username:"Anna")[:id]

      # Act
      get user_path(id)

      # Assert
      must_respond_with :success
    end
  end


      it "must get login_form" do
    get login_path

    must_respond_with :success
  end

  describe "logging in" do
    it "can login a new user" do
      user_hash = {
          user: {
              username: "Gina Atto"
          }
      }

      expect{
        post login_path, params: user_hash
      }.must_differ "User.count", 1

      must_respond_with :redirect

      end
    end
  end
