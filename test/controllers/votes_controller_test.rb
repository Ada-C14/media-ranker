require "test_helper"

describe VotesController do
  describe "create" do
    it "will not let a logged out user vote" do
      # did not perform login so no user should be logged in
      work = works(:hp1)
      expect {
        post work_upvote_path(work)
      }.wont_differ work.votes_count

      expect(flash[:error]).wont_be_nil
    end

    it "will let a logged in user vote for a work not voted before by same user" do
      work = works(:hp1)
      user = User.create!(username: "Jodie")

      perform_login(user)

      expect {
        post work_upvote_path(work)
      }.must_differ work.votes_count

      vote = Vote.find_by(user_id: user.id)
      expect(vote.user).must_equal user
      expect(vote.work).must_equal work

      expect(flash[:success]).wont_be_nil
    end

    it "will not let a logged in user vote more than once on the same work" do
      vote = votes(:vote_1)
      user = vote.user
      work = vote.work

      perform_login(user)

      expect {
        post work_upvote_path(work)
      }.wont_differ work.votes_count

      expect(flash[:error]).wont_be_nil

    end
  end
end
