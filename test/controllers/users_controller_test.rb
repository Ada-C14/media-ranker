require "test_helper"

describe UsersController do
  describe "current" do
    it "returns 200 OK for a logged-in user" do
      # Arrange
      perform_login
    
      # Act
      get user_path(session[:user_id])
    
      # Assert
      must_respond_with :success
    end    
  end
end
