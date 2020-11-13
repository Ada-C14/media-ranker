require "test_helper"

describe UsersController do
  it "must get login_form" do
    get loggin_path

    must_respond_with :success
  end

  describe "logging in" do
    it "can login a new user" do
      user_hash = {
          user: {
              username: "Ed"
          }
      }
      expect {
        post login_path, params: user_hash
      }.must_differ "User.count", 1

      must_respond_with :redirect
      user = User.find_by(username: user_hash[:user][:username])

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal user_hash[:user][:username]
    end
  end


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
  #
  # it "can login an existing user" do
  #   user = User.create(username: "Ed")
  #
  #   expect {
  #     login(user.username)
  #   }.wont_change "User.count"
  # end

  describe "logout" do
    it "can logout in user" do
      login()
      expect(session[:user_id]).wont_be_nil

      post logout_path
      expect(session[:user_id]).must_be_nil
    end
  end

  describe "current user" do
    it "it can return the page if the user logged in" do
      login()

      get current_user_path
      must_respond_with :success
    end

    it "redirect us back ifuser is not logged in" do
      get current_user_path
      must_respond_with :redirect
      expect(flash[:error]).must_equal "you must be logged in to view this page"
    end
  end
end
