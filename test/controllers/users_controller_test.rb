require "test_helper"

describe UsersController do
  # it "current user can return a page if the user is logged in" do
  #   # Arrange
  #   login_path
  #
  #   # Act
  #   get current_user_path
  #
  #   # Assert
  #   must_respond_with :success
  #
  # end
  # How to adapt what Chris did?

  it "current user redirects us to login page if user isn't logged in" do
    # Arrange
    # No current user

    # Act
    get current_user_path

    # Assert
    must_respond_with :redirect
    expect(flash[:error]).must_equal "You must log in"
  end
end
