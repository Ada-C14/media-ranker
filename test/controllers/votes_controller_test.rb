require "test_helper"

describe VotesController do
  describe "upvote" do
    before do
      @dune = works(:dune)
      @pooh = users(:pooh)
      @pooh_vote_dune = votes(:pooh_dune)
    end

    it "creates a vote when user is logged in and redirects" do
      login()

      expect{
        post work_upvote_path(@dune)
      }.must_change "Vote.count", 1


      must_respond_with :redirect
    end

    it "does not create a vote when a user is not logged in" do
      expect{
        post work_upvote_path(@dune)
      }.wont_change "Vote.count"

      must_respond_with :redirect
    end

    it "does not create a vote for a work that a logged-in user has already voted on and redirects" do
      login(@pooh.username)

      expect{
        post work_upvote_path(@dune)
      }.wont_change "Vote.count"

      must_respond_with :redirect
    end

    it "does not create a vote for a work that doesn't exist and redirects" do
      login()

      expect{
        post work_upvote_path(-1)
      }.wont_change "Vote.count"

      must_respond_with :redirect
    end
  end
end