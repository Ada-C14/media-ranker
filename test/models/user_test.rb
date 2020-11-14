require "test_helper"

describe User do

  let (:user) {
    User.create(username: 'annakim')
  }

  it 'can be instantiated with the required fields' do
    expect(user.valid?).must_equal true

    user = User.first
    expect(user).must_respond_to :username
  end

  describe 'relationships' do

  end

  describe 'validations' do
    it 'must have a username' do
      user.username = nil
      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :username
    end

    it 'must have a unique username' do
      user
      user2 = User.create(username: 'annakim')

      expect(user2.valid?).must_equal false
      expect(user2.errors.messages).must_include :username
      expect(user2.errors.messages[:username]).must_equal ['has already been taken']
    end
  end

  describe 'custom methods' do
    it 'includes_work? returns true if user voted for work' do

    end

    it 'includes_work? returns false if user did not vote for work' do

    end

    it 'sorted_votes_user_creation: will sort by vote count; then by created_at' do

    end
  end
end
