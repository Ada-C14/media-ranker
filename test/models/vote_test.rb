require "test_helper"

describe Vote do
  describe "relationships" do
    before do
      @work = works(:book2)
      @user = users(:testuser)
      @vote = Vote.new(user_id: @user.id, work_id: @work.id)
    end

    it "has a user" do
      @vote.save

      expect(@vote.user).must_equal @user
    end

    it "has a work" do
      @vote.save

      expect(@vote.work).must_equal @work
    end
  end

  describe "validations" do
    before do
      @user = User.first
      @work = Work.first
    end

    it "creates a vote when given a user and work" do
      # vote = Vote.new(user_id: @user.id, work_id: @work.id)
      vote = Vote.new(user: @user, work: @work)

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
end
