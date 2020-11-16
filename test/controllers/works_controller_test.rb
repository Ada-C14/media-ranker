require "test_helper"

describe WorksController do
  describe "upvote" do
    it "can upvote" do
      login
      media = works(:treat)

      post work_upvote_path(media.id)
      expect(media.votes.count).must_equal 1
    end
  end
end
