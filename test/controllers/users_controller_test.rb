require "test_helper"

describe UsersController do

  # let (:user_hash) {
  #     {
  #         user: {
  #             username: 'annakim'
  #         }
  #     }
  # }

  it "can get the login form" do
    get login_path
    must_respond_with :success
  end

  describe "log in" do
    it "can log in a new user" do
      user = nil
      test_username = 'hannakix'
      expect { user = login(test_username) }.must_differ 'User.count', 1
      must_respond_with :redirect

      expect(user.username).must_equal test_username
      expect(session[:user_id]).must_equal user.id
    end

    it "can log in an existing user" do
      user = User.create(username: 'annabanana')

      expect { login(user.username) }.wont_change 'User.count'
      expect(session[:user_id]).must_equal user.id
    end
  end

  describe 'log out' do
    it 'can log out a logged-in user' do
      login
      expect(session[:user_id]).wont_be_nil

      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end
end
