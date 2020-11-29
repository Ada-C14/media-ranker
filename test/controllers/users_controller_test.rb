require "test_helper"

describe UsersController do

  describe "index" do
    it "can get the index path" do
      # Act
      get users_path
      # Assert
      must_respond_with :success
    end
  end

  describe "new" do
    it "can get the new user" do

      # Act
      get new_user_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid user" do
      # Act
      get user_path(users(:first))

      # Assert
      must_respond_with :success
    end

    it "will show flash and render status for invalid id" do
      # Act
      get user_path(-1)

      # Assert
      must_respond_with :render

    end

    describe "current" do
      it "returns 200 OK for a logged-in user" do
        # Arrange
        perform_login(users(:second))

        # Act
        get current_user_path

        # Assert
        must_respond_with :success
      end
    end
  end

  describe "create" do
    it "can create a new user" do

      # Act-Assert

      # must_respond_with :redirect
    end
  end


end
