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
      user =
          # Act
          get user_path(user.id)

      # Assert
      must_respond_with :success
    end

    it "will show flash and render status for invalid id" do
      # Act
      get user_path(-1)

      # Assert
      must_respond_with :render

    end
  end


  describe "create" do
    it "can create a new user" do

      # Act-Assert

      # set fixtures

      must_respond_with :redirect
    end
  end

  # describe "edit" do
  #   it "can get the edit page for an existing user" do
  #     # Act
  #     get edit_user_path(user.id)
  #
  #     # Assert
  #     must_respond_with :success
  #   end
  #
  #   it "will respond with redirect when attempting to edit a nonexistant user" do
  #     # Act
  #     get edit_user_path(-1)
  #
  #     # Assert
  #     must_respond_with :redirect
  #   end
  # end
  #

end
