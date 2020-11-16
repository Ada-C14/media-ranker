require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_index_url
    assert_response :success
  end

  test "should get show" do
    get users_show_url
    assert_response :success
  end

  describe UsersController do
    it "can get the login form" do
      get users_login_form_url
      assert_response :success
    end
  end

  describe "logging in" do
    it "can log in a new user" do
      # # arrange ----put in test_helper
      # user_hash = {
      #     user: {
      #         username: 'Test User'
      #     }
      # }
      #
      # expect {
      # # act
      # post login_path, params: user_hash
      # }.must_differ "User.count", 1
      #
      # must_respond_with :redirect
      # user = User.find_by(username: user_hash[:user][:username])
      # expect(user).wont_be_nil
      # expect(session[:user_id]).must_equal user.id
      # expect(user.username).must_equal user_hash[:user][:username]
      #
      # ----refactored below
      user = nil
      expect {
        user = login()
      }.must_differ "User.count", 1

      must_respond_with :redirect

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal user_hash[:user][:username]
    end

    it "can login an existing user" do
      user = User.create[username: "Tester person"]

      expect {
        login(user.usernmae)
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.id
    end
  end
end
