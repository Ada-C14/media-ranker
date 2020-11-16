require 'test_helper'

class WorkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  describe Work do
    describe "custom methods" do
      describe "spotlight" do
        it "returns work with most votes" do
          # Destroy all existing votes
          Vote.destroy_all

          # Create a vote for movie
          Vote.create(work: works(:movie), user: users(:user1))

          # Create 2 votes for movie2 from existing users
          valid_user1 = users(:user1)
          valid_user2 = users(:user2)

          Vote.create(work: works(:movie2), user: valid_user1)
          Vote.create(work: works(:movie2), user: valid_user2)

          # Spotlight must be movie 2
          expect(Work.spotlight).must_equal works(:movie2)
          expect(Work.spotlight).wont_be_nil
        end
      end
    end
  end
end
