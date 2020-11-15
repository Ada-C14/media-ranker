require "test_helper"

describe User do
  it "can be instantiated" do
    expect(users(:user1).valid?).must_equal true
  end

  it "will have the required fields" do
    expect(users(:user1)).must_respond_to :username
  end

  describe "can be validated" do
    it "must have a username" do
      users(:user5).username = nil

      expect(users(:user5).valid?).must_equal false
      expect(users(:user5).errors.messages).must_include :username
    end
  end

  describe "has valid relationships" do
    it "can have many votes" do
      expect(users(:user2).votes.first).must_be_instance_of Vote
      expect(users(:user2).votes.last).must_be_instance_of Vote
      expect(users(:user2).votes.count).must_equal 2
      expect(votes(:vote2).work).must_be_instance_of Work
      expect(votes(:vote2).work).must_equal works(:work2)

    end
  end

end
