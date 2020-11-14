require "test_helper"

describe UsersController do
  describe "current" do
    it "can get the login form" do
      get login_path
      must_respond_with :success
    end

    it "returns 200 OK for a logged-in user" do
      # Arrange
      user = perform_login 
      
      # Act
      get user_path(user.id)

      # Assert
      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id

      must_respond_with :success
    end  
    
    it "can login an existing user" do
      user = User.create!(username: "Good Morning")

      expect {
        perform_login(user)
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.id
    end
  end
end
