require "test_helper"

describe User do
  describe "relationships" do
    it "has votes" do
      user = users(:kato)

      expect(user).must_respond_to :votes
      user.votes.each do |vote|
        expect(vote).must_be_kind_of Vote
      end
    end
    it "has works it has voted for" do
      user = users(:kato)

      expect(user).must_respond_to :works
      user.works.each do |work|
        expect(work).must_be_kind_of Work
      end
    end
  end
  describe "validations" do
    it "validates the presence of a user name" do
      user_one = users(:dexter)
      user_one.name = nil
      user_one.save

      expect(user_one.valid?).must_equal false
      expect(user_one.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "validates that a user name is unique" do
      user_one = users(:dexter)
      user_two = User.new(name: 'dexter')
      user_two.save

      expect(user_two.valid?).must_equal false
      expect(user_two.errors.messages[:name]).must_equal ["has already been taken"]
    end
  end
end
