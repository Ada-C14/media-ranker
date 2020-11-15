require "test_helper"

describe User do
  it 'can be instantiated with the required fields' do
    user = User.first
    expect(user.valid?).must_equal true
    expect(user).must_respond_to :username
  end

  describe 'relationships' do
    it 'can have many votes' do
      user = User.first

      expect(user.votes.count).must_equal 2

      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it 'can have many works through votes' do
      user = User.first

      expect(user.works.count).must_equal 2

      user.works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end
  end

  describe 'validations' do
    it 'must have a username' do
      user = User.first
      user.username = nil
      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :username
    end

    it 'must have a unique username' do
      user2 = User.create(username: 'goybean')

      expect(user2.valid?).must_equal false
      expect(user2.errors.messages).must_include :username
      expect(user2.errors.messages[:username]).must_equal ['has already been taken']
    end
  end

  describe 'custom methods' do
    it 'includes_work? returns true if user voted for work' do
      user = User.first
      expect(user.includes_work?(works(:ctrl).id)).must_equal true
    end

    it 'includes_work? returns false if user did not vote for work' do
      user = User.first
      expect(user.includes_work?(works(:no_dream).id)).must_equal false
    end

    it 'sort_users: will sort by vote count; then by created_at' do
      sorted_users = User.sort_users
      p sorted_users
      expect(sorted_users[0].username).must_equal 'goybean'
      expect(sorted_users[1].username).must_equal 'chlobofosho'
      expect(sorted_users[2].username).must_equal 'annakim'
    end
  end
end
