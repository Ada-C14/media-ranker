require "test_helper"

describe UsersController do
  before do
    @user = users(:me)
  end

  describe 'index' do
    it 'can get the index page' do
      get users_path

      must_respond_with :success
    end
  end

  describe 'show' do
    it 'can get the show page' do

      get user_path(@user.id)

      must_respond_with :success
    end

    it 'will redirect for invalid user' do

      get user_path(-1)

      must_respond_with :redirect
    end
  end

  describe 'login_form' do
    it 'can get the login form' do

      get login_path

      must_respond_with :success
    end

  end

  describe 'login' do
    it 'new user login will create new user & respond with success' do
      new_user = {
          user: {
              name: "cleetus68"
          }
      }
      post login_path, params: new_user

      expect(flash[:success]).must_equal "Successfully logged in as new user cleetus68"

      expect(session[:user_id]).must_be_instance_of Integer

      must_respond_with :redirect
    end

    it "returning login user will be success" do
      perform_login(@user)

      expect(flash[:success]).must_equal "Successfully logged in as returning user iris-lux"

      expect(session[:user_id]).must_equal @user.id

      must_respond_with :redirect
    end

    it 'user login will respond with error if user name is blank' do
      new_user = {
          user: {
              name: ""
          }
      }
      post login_path, params: new_user

      expect(flash[:error]["failed_action"]).must_equal "A problem occurred: Could not login"
      expect(flash[:error]["errors"][0]).must_equal "name: can't be blank"

      expect(session[:user_id]).must_be_nil

      must_respond_with :redirect
    end
  end

  describe 'logout' do

    it ' can successfully logout' do
      perform_login(@user)

      post logout_path

      expect(session[:user_id]).must_be_nil

      expect(flash[:success]).must_equal "Successfully logged out"

      must_respond_with :redirect
    end
  end
end
