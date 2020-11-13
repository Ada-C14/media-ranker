require "test_helper"

describe UsersController do
  # it "must get login_form" do
  #   get users_login_form_url
  #   must_respond_with :success
  # end
  #
  # it "must get login" do
  #   get users_login_url
  #   must_respond_with :success
  # end

  it "returns 200 OK for a logged-in user" do
    # Arrange
    perform_login

    # Act
    get current_user_path

    # Assert
    must_respond_with :success
  end

  it "can login an existing user" do
    user = User.create(username: "Ed")

    expect {
      login(user.username)
    }.wont_change "User.count"
  end

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
