require "test_helper"

describe Vote do
  before do
    @vote = votes(:vote1)
  end

  describe "instantiation" do
    it "can be instantiated" do
      expect(@vote.valid?).must_equal true
    end
  end

  describe "validations" do
    it "is invalid when the user_id vote twice for the same work" do
      vote2 = Vote.create(work_id: @vote.work_id, user_id: @vote.user_id)

      expect(vote2.valid?).must_equal false
      expect(vote2.errors.messages).must_include :work_id
      expect(vote2.errors.messages[:work_id]).must_equal ["has already been taken"]
    end
  end

  describe "relations" do
    it "belongs to one user" do
      expect(@vote.user).must_be_instance_of User
      expect(@vote.user).must_equal users(:user1)
    end

    it "belongs to one work" do
      expect(@vote.work).must_be_instance_of Work
      expect(@vote.work).must_equal works(:work1)
    end
  end

end
