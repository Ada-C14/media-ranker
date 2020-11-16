require "test_helper"

describe UsersController do
  it 'can get the login form' do
    get login_path

    must_respond_with :success
  end

  describe 'logging in' do
    it 'can login a new user' do
      user = nil
      expect {
        login()
      }.must_differ 'User.count', 1

      must_respond_with :redirect


      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal user_hash[:user][:username]
    end
  end
end
