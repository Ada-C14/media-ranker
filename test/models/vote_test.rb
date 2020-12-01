require "test_helper"

describe Vote do

  describe "relations" do
    it "has a user" do
      vote = votes(:one)

      expect(vote).must_respond_to :user
      expect(vote.user).must_be_kind_of User
    end

    it "has a work" do
      vote = votes(:one)
      expect(vote).must_respond_to :work
      expect(vote.work).must_be_kind_of Work
    end
  end

  describe "validations" do
    it "validates uniqueness of user id when voting for work" do
      vote_one = votes(:one)
      vote_two = Vote.new(user: users(:dexter), work: works(:mov_one))


      expect(vote_one.valid?).must_equal true
      expect(vote_two.valid?).must_equal false

      expect(vote_two.errors.messages[:user_id]).must_equal ['user: has already voted for this work']
    end

    it "allows a user to vote for multiple works" do
      vote_one = votes(:two)
      vote_two = Vote.new(user: users(:kato), work: works(:book_one))
      vote_two.save
      expect(vote_two.valid?).must_equal true
    end

  end
end
