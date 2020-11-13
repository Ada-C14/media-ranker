require "test_helper"

describe UsersController do
  describe 'index' do
    it 'get index' do
      get users_path

      must_respond_with :success
    end
  end

  describe 'show' do
    it 'will get show for valid ids' do
      valid_user_id = User.first.id

      get user_path(valid_user_id)

      must_respond_with :success
    end

    it 'will respond with not found for invalid user ids' do
      get user_path(-1)

      must_respond_with :not_found
    end
  end

  describe 'login' do
    it 'can get the login form' do
      get login_path

      must_respond_with :success
    end

    it 'can login a new user' do
      user_hash = {
          user: {
              username: "A New User"
          }
      }

      expect {
        post login_path, params: user_hash
      }.must_change "User.count", 1

      user = User.find_by(username: "A New User")
      must_respond_with :redirect
      expect(session[:user_id]).must_equal user.id
    end

    it 'can log in an existing user' do
      expect {
        perform_login
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal User.first.id
    end
  end

  describe 'logout' do
    it "can logout a logged in user" do
      perform_login
      expect(session[:user_id]).must_equal User.first.id

      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end
end
