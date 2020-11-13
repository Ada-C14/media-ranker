require "test_helper"

describe Vote do
  describe 'relations' do
    it "has a work" do
      vote = votes(:user1_work1)
      expect(vote.work_id).must_equal works(:kreb_album).id
    end

    it "has an user" do
      vote = votes(:user1_work1)
      expect(vote.user_id).must_equal users(:john).id
    end
  end
end
