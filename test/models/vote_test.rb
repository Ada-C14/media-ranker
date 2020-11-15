require "test_helper"

describe Vote do
  before do
    @user1 = users(:louise)
    @work1 = works(:us)
    @vote = Vote.create(user_id: @user1.id, work_id: @work1.id)
  end

  describe "instantiation" do
    it "can be instantiated" do
      expect(@vote.valid?).must_equal true
    end

    it "will have the required fields" do
      expect(@vote).must_respond_to :user_id
      expect(@vote).must_respond_to :work_id
    end
  end
  
  describe "validation" do
    it "will create a new Vote if required fields exist" do
      user = users(:gene)
      work = works(:becoming)
      new_vote = Vote.new(user: user, work: work)

      expect(new_vote.valid?).must_equal true
      expect(new_vote.user.name).must_equal user.name
      expect(new_vote.work.title).must_equal work.title
    end

    it "will not create a new Vote if user has upvoted work before" do
      new_vote = Vote.new(user_id: @user1.id, work_id: @work1.id)

      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages[:user_id]).must_include "User has already voted for this work"
    end

    it "will not create a new Vote if required fields are missing" do
      new_vote = Vote.new()

      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages[:user]).must_include "must exist"
      expect(new_vote.errors.messages[:work]).must_include "must exist"
    end

    it "will not create a new Vote if user_id is nil" do
      new_vote = Vote.new(user_id: nil, work_id: @work1.id)

      expect(new_vote.valid?).must_equal false
    end

    it "will not create a new Vote if work_id is nil" do
      new_vote = Vote.new(user_id: users(:linda).id, work_id: nil)

      expect(new_vote.valid?).must_equal false
    end
  end

  describe "relationships" do
    it "vote belongs to a user" do
      vote = votes(:vote1)

      expect(vote.user).must_be_instance_of User
      expect(vote.user).must_equal users(:bob)
    end

    it "vote belongs to a work" do
      vote = votes(:vote1)

      expect(vote.work).must_be_instance_of Work
      expect(vote.work).must_equal works(:rare)
    end
  end
end
