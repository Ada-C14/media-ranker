require "test_helper"

describe UsersController do
  desc

  describe "index" do
    it "responds with success when users are saved" do
      user = users()

      get users_path

      must_respond_with :success
    end

    it "responds with success when no users are saved" do
      User.destroy_all

      get users_path

      must_respond_with :success
    end
  end

  describe "login_form" do
    it "responds with success" do
      get login_path

      must_respond_with :success
    end
  end

  describe "login" do
    it "can login a new user" do
      expect{
        user = login("New User")
      }.must_change "User.count", 1

      must_respond_with :redirect
      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal User.first.username
    end

    it "can login an existing user" do
      user = user(:pooh)

      expect {
        login(user.username)
      }.wont_change "User.count", 1

      must_respond_with :redirect
      expect(session[:user_id]).must_equal user.id
    end
  end

  describe "logout" do
    it "can logout a logged in user" do
      login()
      expect(session[:user_id]).wont_be_nil

      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end

  # describe "create" do
  #   it "creates a user with valid input and redirects" do
  #     valid_user_hash = {
  #       user: {
  #         username: "eeyore"
  #       }
  #     }
  #
  #     expect{
  #       post users_path, params: valid_user_hash
  #     }.must_change "User.count", 1
  #
  #     must_respond_with :redirect
  #   end
  #
  #   it "does not create a user without a username" do
  #     invalid_user_hash = {
  #       user: {
  #         username: nil
  #       }
  #     }
  #
  #     expect{
  #       post users_path, params: invalid_user_hash
  #     }.wont_change "User.count"
  #
  #     must_respond_with :render
  #   end
  # end

  describe "show" do
    it "responds with success when showing an existing user" do
      user = users(:pooh)

      get users_path(user)

      must_respond_with :success
    end

    it "responds with 404 when showing a non-existent user" do
      get users_path(-1)

      must_respond_with :success
    end
  end

end
