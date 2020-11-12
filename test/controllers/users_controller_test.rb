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
      expect { login('annakim') }.must_differ 'User.count', 1
      must_respond_with :redirect

      user = User.find_by(username: user_hash[:user][:username])

      expect(user.username).must_equal user_hash[:user][:username]
      expect(session[:user_id]).must_equal user.id
    end

    it "can log in an existing user" do
      user = User.create(username: 'annabanana')

      expect { login(user.username) }.wont_change 'User.count'
      expect(session[:user_id]).must_equal user.id
    end
  end
end
