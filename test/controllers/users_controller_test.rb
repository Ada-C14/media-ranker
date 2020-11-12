require "test_helper"

describe UsersController do

  before do
    @user = User.create!(name: "test user")
  end

  describe "index" do
    it "must get index" do
      skip
    end

    it "doesnt break when there are no users" do
      skip
    end
  end

  describe "show" do
    it "must get show" do
      skip
      # must_respond_with :success
    end

    it "redirects to error page for invalid show" do
      skip
      # must redirect somewhereeeeee
    end
  end

  describe "login_form" do
    it "can get the login form page" do
      get login_url
      must_respond_with :success
    end
  end

  describe "login" do

    it "can login" do
      perform_login
    end

  end

  describe "logout" do
    it "can logout" do
      skip
    end
  end

end
