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
        user = login()
      }.must_differ 'User.count', 1

      must_respond_with :redirect
      user = User.find_by(username: 'Grace Hopper')

      expect(user).wont_be_nil
      expect(session[:user_id]).must_equal user.id
    end

    it 'can login in an existing user' do
      user = User.create(username: 'Ed Sheeran')

      expect {
        login(user.username)
      }.wont_change 'User.count'

      expect(session[:user_id]).must_equal user.id
    end
  end

  describe 'logging out' do
    it 'can loggout a logged in user' do
      # Arrange
      login()
      expect(session[:user_id]).wont_be_nil

      # Act
      post logout_path

      expect(session[:user_id]).must_be_nil
    end

  end

  describe 'current user' do
    # deleted current user path because looks the same as show page
    # it 'can return the current user page if the user is logged in' do
    # login()
    #
    #   get current_user_path
    #
    #   must_respond_with :success
    # end

    it 'can upvote if logged in' do
      login()
      work = works(:book1)

      # Act / Expect
      expect{
        post work_votes_path(work)
      }.must_differ "Vote.count", 1

    end

    it 'cannot upvote if not logged in' do
      work = works(:book1)

      # Act / Expect

      expect{
        post work_votes_path(work)
      }.wont_change "Vote.count"
    end
  end
end
