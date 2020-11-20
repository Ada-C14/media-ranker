require "test_helper"

describe User do

  # Test relations
  describe "has valid relationships" do
    it "can have many votes" do
      expect(users(:user_2).votes.first).must_be_instance_of Vote
      expect(users(:user_2).votes.last).must_be_instance_of Vote
      expect(users(:user_2).votes.count).must_equal 2
      expect(votes(:vote_2).work).must_be_instance_of Work
      expect(votes(:vote_2).work).must_equal works(:work_3)

    end
  end
  it "can be instantiated" do
    expect(users(:user_1).valid?).must_equal true
  end

  it "will have the required fields" do
    expect(users(:user_1)).must_respond_to :username
  end
  # Test validations
  describe "can be validated" do
    it "must have a username" do
      users(:user_5).username = nil

      expect(users(:user_5).valid?).must_equal false
      expect(users(:user_5).errors.messages).must_include :username
    end
  end

end
