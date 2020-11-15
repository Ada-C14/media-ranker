require "test_helper"

describe Vote do
  it "can be instantiated" do
    expect(votes(:vote2).valid?).must_equal true
  end

  describe "can be validated" do
    it "raises an error when there are two votes for the same user" do
      expect(votes(:vote6).valid?).must_equal false
      expect(votes(:vote6).errors.messages).must_include :work_id
    end
  end

  describe "has valid relationships" do
    it "has one user and one work" do
      expect(votes(:vote3).user).must_be_instance_of User
      expect(votes(:vote3).user).must_equal users(:user3)
      expect(votes(:vote3).work).must_be_instance_of Work
      expect(votes(:vote3).work).must_equal works(:work3)

    end
  end
end
