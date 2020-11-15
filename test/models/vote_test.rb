require "test_helper"

describe Vote do

  before do
    @vote1 = votes(:vote1)
    @vote2 = votes(:vote2)
    @vote3 = votes(:vote3)

    @user1 = users(:user1)

    @work1 = works(:movie1)
  end

  describe "relationships" do
    it "is valid with a user and work" do
      result = @vote1.valid?
      expect(result).must_equal true
    end

    it "must have a user" do
      @vote1.user = nil

      result = @vote1.valid?
      expect(result).must_equal false
    end

    it "must have a work" do

      @vote1.work = nil

      result = @vote1.valid?
      expect(result).must_equal false
    end
  end

  describe "validations" do
    it "does not allow a user to vote for the same work more than once" do
      @new_vote = Vote.create(user: @user1, work: @work1)

      result = @new_vote.valid?
      expect(result).must_equal false
    end
  end
end
