require "test_helper"

describe Vote do
  describe "relationships" do
    it "belongs to a work" do
      media = works(:treat)
      user = users(:nagai)
      vote = Vote.create(work_id: media, user_id: user)

      vote.work = media
      expect(vote.work_id).must_equal media.id
    end

    it "belongs to a user" do
      media = works(:treat)
      user = users(:nagai)
      vote = Vote.create(work_id: media, user_id: user)

      vote.user = user
      expect(vote.user_id).must_equal user.id
    end
  end
end
