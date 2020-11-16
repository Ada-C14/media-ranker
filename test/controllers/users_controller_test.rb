require "test_helper"

describe UsersController do
  describe "index" do
    it "responds with success " do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "responds with success when showing an existing user" do
      valid_test_user = users(:user_1)
      get users_path "#{valid_test_user.id}"
      must_respond_with :success
    end
  end

  describe "loggin_form" do
    it "must get login_form" do
      User.new({username: "Ed Mt"})
      get login_path
      must_respond_with :success
    end
  end

  describe "login" do
    it "can login a new user" do
      user = nil
      expect{
        user = login()
      }.must_differ "User.count", 1
      must_respond_with :redirect
      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
      expect(user.username).must_equal "Grace Hopper"
    end

    it "can login an existing user" do
      user = User.create(username: "Ed Sheeran")
      expect{
        login(user.username)
      }.wont_change "User.count"
      expect(session[:user_id]).must_equal user.id
      must_respond_with :redirect
    end
  end


end
#
#   describe "logging in" do
#     it "can login a new user" do
#       user = nil
#       expect{
#         user = login()
#       }.must_differ "User.count", 1
#       must_respond_with :redirect
#       expect(user).wont_be_nil
#       expect(session[:user_id]).must_equal user.id
#       expect(user.username).must_equal "Grace Hopper"
#   end
#
#
#
#   describe "logout" do
#     it "can logout in user" do
#       login()
#       expect(session[:user_id]).wont_be_nil
#
#       post logout_path
#       expect(session[:user_id]).must_be_nil
#     end
#   end
#
#   describe "current user" do
#     it "it can return the page if the user logged in" do
#       login()
#
#       get current_user_path
#       must_respond_with :success
#     end
#
#     it "redirect us back ifuser is not logged in" do
#       get current_user_path
#       must_respond_with :redirect
#       expect(flash[:error]).must_equal "you must be logged in to view this page"
#     end
#   end
# end
