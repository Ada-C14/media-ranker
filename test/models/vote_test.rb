require "test_helper"

describe Vote do
  it "can be instantiated" do
    expect(votes(:vote_2).valid?).must_equal true
  end

  describe "can be validated" do
    it "raises an error when there are two votes for the same user" do
      expect(votes(:vote_6).valid?).must_equal false
      expect(votes(:vote_6).errors.messages).must_include :work_id
    end
  end

  describe "has valid relationships" do
    it "has one user and one work" do
      expect(votes(:vote_3).user).must_be_instance_of User
      expect(votes(:vote_3).user).must_equal users(:user_3)
      expect(votes(:vote_3).work).must_be_instance_of Work
      expect(votes(:vote_3).work).must_equal works(:work_3)

    end
  end
end
