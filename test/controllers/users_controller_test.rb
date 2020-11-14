require "test_helper"

describe UsersController do

  let (:new_user) {
    User.create(username: 'annakim')
  }

  it "can get the login form" do
    get login_path
    must_respond_with :success
  end

  describe 'index' do
    it 'responds with success when there are users saved' do
      new_user
      get users_path
      must_respond_with :success
    end

    it 'responds with success when there are no users saved' do
      get users_path
      must_respond_with :success
    end
  end

  describe 'show' do
    it "responds with success when showing an existing valid work" do
      new_user
      get user_path(new_user.id)
      must_respond_with :success
    end

    it "will redirect when passed an invalid work id" do
      get user_path(-1)
      must_respond_with :redirect
    end
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

  describe 'current user' do
    it 'can return user page if a user is logged in' do
      login
      get current_user_path
      must_respond_with :success
    end

    it 'redirects if user is not logged in' do
      get current_user_path
      must_respond_with :redirect
      expect(flash[:notice]).must_equal 'Please log in to perform this action'
    end
  end
end
