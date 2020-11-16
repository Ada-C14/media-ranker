require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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
  end
end
