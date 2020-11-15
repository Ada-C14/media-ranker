require "test_helper"

describe VotesController do
  describe "upvote" do
    it "creates a vote and redirects" do
      work = works(:dune)


      login()

      expect{
        post work_upvote_path(work)
      }.must_change "Vote.count", 1


      must_respond_with :redirect
    end


  end
end
