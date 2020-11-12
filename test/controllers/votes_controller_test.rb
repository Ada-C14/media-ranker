require "test_helper"

describe VotesController do
  describe "upvote" do
    it "sucessfully creates a vote and redirects to the work path for a logged-in user" do
      perform_login(users(:user3))

      work = works(:album)

      expect{
        post work_upvote_path(work.id)
      }.must_change "work.votes.count", 1

      must_respond_with :redirect
      must_redirect_to work_path(work.id)
    end

    it "does not create a vote if a user is not logged-in" do
      work = works(:movie)

      expect {
        post work_upvote_path(work.id)
      }.wont_change "work.votes.count"
    end

    it "does not create a vote if a user has already voted for a work" do
      perform_login(users(:user1))

      work = works(:book)

      expect {
        post work_upvote_path(work.id)
      }.wont_change "work.votes.count"

    end
  end
end
