require "test_helper"

describe User do
  describe "validations" do
    it "is valid when all fields are present" do
      user = User.new(username: "test username")
      result = user.valid?
      expect(result).must_equal true
    end

    it "must have a username" do
      result = users(:harry)
      result[:username] = nil
      expect(result.valid?).must_equal false
    end

    it "must have a unique username" do
      user = users(:harry)
      user_copy = User.new(username: "Harry")
      expect(user_copy.valid?).must_equal false
    end
  end

  describe "custom methods" do

  end

  describe "relationships" do
    it "can have many works through votes" do
      user = users(:harry)
      expect(user.works.length).must_equal 2
      expect(user.works.first).must_equal works(:hp1)
      expect(user.works.last).must_equal works(:hp2)
    end

    it "can have many votes" do
      user = users(:harry)
      expect(user.votes.length).must_equal 2
    end
  end
end
