require "test_helper"

describe Vote do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  describe "validations" do
    it "lets different users vote for the same work" do
      vote1 = Vote.new(user: users(:user1), work: works(:work1))
      vote1.save
      vote2 = Vote.new(user: users(:user2), work: works(:work1))
      expect(vote2.valid?).must_equal true
    end

    it "lets user vote for multiple works" do
      vote1 = Vote.new(user: users(:user1), work: works(:work1))
      vote1.save
      vote2 = Vote.new(user: users(:user1), work: works(:work2))
      expect(vote2.valid?).must_equal true
    end

    it "doesnt let the same user vote for the same work twice" do
      vote1 = Vote.new(user: users(:user1), work: works(:work1))
      vote1.save
      vote2 = Vote.new(user: users(:user1), work: works(:work1))
      expect(vote2.valid?).must_equal false
    end
  end

  describe "relationships" do
    it "has a user" do
      vote1 = votes(:vote1)
      expect(vote1).must_respond_to :user
      expect(vote1.user).must_be_kind_of User
    end

    it "has a work" do
      vote2 = votes(:vote2)
      expect(vote2).must_respond_to :work
      expect(vote2.work).must_be_kind_of Work
    end
  end
end
