require "test_helper"

describe User do
  describe "validations" do
    before do
      @user = User.new(username: "bananapants")
    end

    it "creates a user when given valid input" do
      success = @user.valid?

      expect(success).must_equal true
    end

    it "won't create a user without a username" do
      @user.username = nil

      success = @user.valid?

      expect(success).must_equal false
    end

    it "won't create a user with a repeat name" do
      @user.save
      clone_user = User.new(username: "bananapants")

      success = clone_user.valid?

      expect(success).must_equal false
    end
  end

  describe "relationships" do
    before do
      @user = User.first
      @work = Work.first
      @vote = Vote.new(user: @user, work: @work)
    end

    it "can have a vote" do
      @vote.save

      expect(@user.votes.count).must_equal 1
      expect(@user.votes.first).must_equal @vote
    end

    it "can have a work through a vote" do
      @vote.save

      expect(@user.works).must_include @work
    end
  end
end
