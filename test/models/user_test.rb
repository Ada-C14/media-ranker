require "test_helper"

describe User do
  before do
    @user = User.new(
        username: "Test user",
        )
  end
  describe 'initialize' do
    it 'can be initialized' do
      expect(@user.valid?).must_equal true
    end

    it "will have the required fields" do
      @user.save

      work = User.find_by(username: "Test user")

      expect(work).must_respond_to :username
    end
  end

  describe 'validations' do
    it 'is valid when the required fields are present' do
      result = @user.valid?
      expect(result).must_equal true
    end

    it 'is invalid without a username' do
      @user.username = nil

      result = @user.valid?
      expect(result).must_equal false
    end
  end

  describe 'relations' do
    it 'can have many Votes' do
      work = works(:book)

      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
      expect(work.votes.count).must_equal 3
    end
  end

  describe 'vote_count' do
    it 'returns the number of votes for a user' do
      user = users(:user2)
      votes = user.vote_count

      expect(votes).must_equal 3
    end

    it 'returns 0 if the user has no votes' do
      user = @user
      votes = user.vote_count

      expect(votes).must_equal 0
    end
  end
end
