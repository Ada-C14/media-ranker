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

end
