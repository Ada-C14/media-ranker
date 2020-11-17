require "test_helper"

describe User do
  describe "relationships" do
    it "has votes and associated works" do
      user_1 = users(:user_1)

      expect(user_1).must_respond_to :votes
      expect(user_1).must_respond_to :works

      user_1.votes.each do |vote|
        expect(vote).must_be_kind_of Vote
      end
      user_1.works.each do |work|
        expect(work).must_be_kind_of Work
      end
    end
  end

  describe "validations" do
    it "must have a username" do
      user = User.new
      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :username
    end
  end
end
