require "test_helper"

describe UsersController do
  describe 'index' do
    it 'get index' do
      get users_path
      must_respond_with :success
    end
  end

  describe 'show' do
    it 'will get show for valid ids' do
      valid_user_id = User.first.id

      get user_path(valid_user_id)

      must_respond_with :success
    end

    it 'will respond with no found for invalid user ids' do
      get user_path(-1)

      must_respond_with :not_found
    end
  end

  describe 'login' do

  end

  describe 'logout' do

  end

  describe 'current' do

  end


end
