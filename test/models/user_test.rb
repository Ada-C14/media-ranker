require "test_helper"

describe User do
  describe "validations" do
    it "valid with valid name" do
      user = users(:user1)
      expect(user.valid?).must_equal true
    end

    it "must have a name" do
      user = users(:user1)
      user.name = nil
      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :name
    end

    it "must have a name" do
      user = users(:user1)
      user.name = nil
      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :name
    end
  end

  describe "relations" do
    it "User can have many Votes" do
      user = users(:user1)
      expect(user.votes.count).must_equal 3
    end

    it "User can have 0 Votes" do
      user = users(:user7)
      expect(user.votes.count).must_equal 0
    end

    it "User can have many Works through Votes" do
      user = users(:user1)
      expect(user.works.count).must_equal 3
    end

    it "User can have 0 Works through Votes" do
      user = users(:user11)
      expect(user.works.count).must_equal 0
    end
  end

  describe "custom methods" do
    it "returns vote_count for a user" do
      user = users(:user1)
      expect(User.vote_count(user)).must_equal 3
    end

    it "returns vote_count for nil user" do
      user = nil
      expect(User.vote_count(user)).must_be_nil
    end

    it "returns date_joined for a user" do
      user = users(:user1)
      expect(User.date_joined(user)).must_equal "Nov 12, 2020"
    end

    it "returns date_joined for nil user" do
      user = nil
      expect(User.date_joined(user)).must_be_nil
    end
  end
end
