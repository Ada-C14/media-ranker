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

    it "does not create a vote for a work that doesn't exist and redirects" do
      login()

      expect{
        post work_upvote_path(-1)
      }.wont_change "Vote.count"

      must_respond_with :redirect
    end

    it "does not create a vote when a user is not logged in" do
      work = works(:dune)

      expect{
        post work_upvote_path(work)
      }.wont_change "Vote.count"

      must_respond_with :redirect
    end
  end
end
