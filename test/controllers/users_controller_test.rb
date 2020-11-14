require "test_helper"

describe UsersController do
  describe "index" do
    it "can get the index page" do
      get "/users"

      must_respond_with :success
    end

    it "can load all the users" do

    end
  end

  describe "show" do

  end

  describe "login" do

  end

  describe "logout" do

  end

  describe "current_user" do

  end
end
