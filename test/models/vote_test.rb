require "test_helper"

describe Vote do
  describe "relationships" do
    it "something" do
      raise NotImplementedError
    end
  end

  describe "validations" do
    before do
      @user = User.first
      @work = Work.first
    end

    it "creates a vote when given a user and work" do
      vote = Vote.new(user_id: @user.id, work_id: @work.id)

      success = vote.valid?

      expect(success).must_equal true
    end

    it "won't create a vote without a user" do
      vote = Vote.new(work_id: @work.id)

      success = vote.valid?

      expect(success).must_equal false
    end

    it "won't create a vote without a work" do
      vote = Vote.new(user_id: @user.id)

      success = vote.valid?

      expect(success).must_equal false
    end

    it "won't create a vote if that user has already voted on that work" do
      vote = Vote.new(user_id: @user.id, work_id: @work.id)
      vote.save
      second_vote = Vote.new(user_id: @user.id, work_id: @work.id)

      success = second_vote.valid?

      expect(success).must_equal false
    end
  end

  describe "upvote" do
    before do
      @user = User.new(username: "ringolingo")
    end

    it "adds a vote to a work when a user is logged in" do
      @user.save
      work = Work.first

      raise NotImplementedError
    end

    it "does not add a vote if there is no logged in user" do
      raise NotImplementedError
    end

    it "does not add a vote to a work logged in user has already voted for" do
      raise NotImplementedError
    end
  end
end
