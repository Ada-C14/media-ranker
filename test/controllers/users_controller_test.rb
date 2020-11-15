require "test_helper"

describe UsersController do

  before do
    @user = users(:test_user)
  end

  let (:bad_user){
    -99999
  }

  describe "index" do
    it "must get index" do
      get users_url
      must_respond_with :success
    end

    it "doesnt break when there are no users" do
      @user.destroy
      users(:second_test_user).destroy
      get users_url
      expect(User.count).must_equal 0
      must_respond_with :success
    end
  end

  describe "show" do
    it "must get show" do
      get user_url(@user.id)
      must_respond_with :success
    end

    it "redirects to error page for invalid user" do
      get user_url(bad_user)
      must_respond_with :not_found
    end
  end

  describe "login_form" do
    it "can get the login form page" do
      get login_url
      must_respond_with :success
    end
  end

  describe "login" do

    it "can login an existing user" do
      perform_login(@user)
      expect(flash[:success]).must_equal "Successfully logged in as existing user #{@user.name}"
    end

    it "can login a new user" do
      second_user = perform_login
      expect(flash[:success]).must_equal "Successfully created new user #{second_user.name} with ID #{second_user.id}"
    end

  end

  describe "logout" do
    it "can logout" do
      post logout_url
      expect(session[:user_id]).must_be_nil
      expect(flash[:success]).must_equal "Successfully logged out"
      must_redirect_to root_url
    end
  end

end
