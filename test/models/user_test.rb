require "test_helper"

describe User do
  describe 'validations' do
    before do
      @user = User.new(
          username: "Test user",
      )
    end

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
end
