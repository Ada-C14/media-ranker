require "test_helper"

describe UsersController do
  describe 'index' do
    it 'get index' do
      get users_path
      must_respond_with :success
    end
  end

  describe 'show' do
    before do
      @user = User.create(username: "test name")
    end

    it 'will get show for valid ids' do


      get user_path(@user.id)

      must_respond_with :success
    end

    it 'will respond with not found for invalid user ids' do
      get user_path(-1)

      must_respond_with :not_found
    end
  end
end
