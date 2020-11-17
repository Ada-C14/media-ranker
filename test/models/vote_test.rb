require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  describe Vote do
    it "can be instantiated" do
      # Arrange
      valid_vote = votes(:vote1)
      # Assert
      expect(valid_vote.valid?).must_equal true
      expect(valid_vote).must_be_instance_of Vote
      expect(valid_vote).wont_be_nil
    end

    it "should have the required fields" do
      # Arrange
      valid_vote = votes(:vote1)
      # Assert
      expect(valid_vote.user_id).wont_be_nil
      expect(valid_vote.work_id).wont_be_nil
      expect(valid_vote).must_respond_to :user_id
      expect(valid_vote).must_respond_to :work_id
    end

    describe "relationships" do
      it "should have a user and work" do
        # Arrange
        valid_vote = votes(:vote1)
        # Assert
        expect(valid_vote.work).must_be_instance_of Work
        expect(valid_vote.user).must_be_instance_of User
      end
    end

    describe "validations" do
      it  "must have a user" do
        # Arrange
        valid_work = works(:movie)
        vote_with_nil_user = Vote.create(user: nil, work: valid_work)
        # Assert
        expect(vote_with_nil_user.valid?).must_equal false
        expect(vote_with_nil_user.errors.messages).must_include :user
        expect(vote_with_nil_user.errors.messages[:user]).must_equal ["must exist"]
        assert_operator vote_with_nil_user.errors.count, :>, 0
      end

      it  "must have a work" do
        # Arrange
        valid_user = users(:user1)
        vote_on_nil_work = Vote.create(user: valid_user, work: nil)
        # Assert
        expect(vote_on_nil_work.valid?).must_equal false
        expect(vote_on_nil_work.errors.messages).must_include :work
        expect(vote_on_nil_work.errors.messages[:work]).must_equal ["must exist"]
        assert_operator vote_on_nil_work.errors.count, :>, 0

      end

      it "should not be saved if user already voted on work" do
        # Arrange
        already_voted = votes(:vote1)
        invalid_new_vote = Vote.new(user_id: already_voted.user_id, work_id: already_voted.work_id)
        # Assert
        expect(invalid_new_vote.valid?).must_equal false
        expect(already_voted).must_be_instance_of Vote
      end
    end
  end
end
