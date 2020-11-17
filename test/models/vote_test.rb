require "test_helper"

describe Vote do
  describe "relationships" do
    it "has a user and a work" do
      vote = votes(:vote_w1_u1)
      expect(vote).must_respond_to :work
      expect(vote).must_respond_to :user
      expect(vote.work).must_be_kind_of Work
      expect(vote.user).must_be_kind_of User
    end
  end

  describe "validations" do
    before do
      @work_1 = Work.find_by(title: :book_1)
      @work_2 = Work.find_by(title: :book_2)
      @work_3 = Work.find_by(title: :book_3)
      @user_1 = User.find_by(username: :Username_1)
      @user_2 = User.find_by(username: :Username_2)
    end

    it "must have a work" do
      vote = Vote.new(user: @user_1)
      expect(vote.valid?).must_equal false
      expect(vote.errors.messages).must_include :work
    end

    it "must have a username" do
      vote = Vote.new(work: @work_1)
      expect(vote.valid?).must_equal false
      expect(vote.errors.messages).must_include :user_id
    end

    it "lets a user vote for different works, and lets two users vote for the same work" do
      # User 3 hasn't voted for work 3 yet so it should let us go through with it
      vote_2 = Vote.new(work: @work_2, user: @user_2)
      expect(vote_2.save).must_equal true
    end

    it "doesn't let a user vote for the same work twice" do
      vote_2 = Vote.new(work: @work_1, user: @user_1)
      expect(vote_2.valid?).must_equal false
      expect(vote_2.errors.messages).must_include :user_id
      end

  end
end

