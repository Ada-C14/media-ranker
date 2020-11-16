require "test_helper"

describe User do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  describe 'validations' do
    before do
      @user = User.new(
          username: "hellogeorge"
      )
    end

    it 'is valid when all fields are present' do
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

    it "has vote(s)" do
      user = users(:user1)
      votes = user.votes

      expect(votes.first).must_be_instance_of Vote
      expect(votes.count).must_equal 3
    end
  end

end
