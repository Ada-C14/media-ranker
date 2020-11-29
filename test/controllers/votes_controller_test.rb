require "test_helper"

describe VotesController do
  describe 'create' do
    it 'can add a new vote' do
      work = works(:test_album)
      user = User.new(name: 'tester')

      perform_login(user)

      expect {
        post work_votes_path(work)
      }.must_differ work.vote_button, 1

      vote = Vote.find_by(user_id: user.id)
      expect(vote.user).must_equal user
      expect(vote.work).must_equal work

      expect(flash[:success]).wont_be_nil
    end
    it 'cannot add a secondary vote to the same work' do
      vote = votes(:new_vote)
      user = vote.user
      work = vote.work

      perform_login(user)

      expect {
        post work_votes_path(work)
      }.wont_differ work.votes_count

      expect(flash[:error]).wont_be_nil
    end
    it 'cannot vote unless logged in' do
      work = works(:test_book)
      expect {
        post work_votes_path(work)
      }.wont_differ 'work.votes.count'

      expect(flash[:warning]).wont_be_nil
    end
  end

  describe 'destroy' do
    it 'can remove an upvote' do
      work = works(:test_album)
      user = User.new(name: 'tester')

      perform_login(user)

      expect {
        delete work_vote_path(work.id)
      }.must_differ work.votes_button, -1

      vote = Vote.find_by(user_id: user.id)
      expect(vote.user).must_equal user
      expect(vote.work).must_equal work

      expect(flash[:success]).wont_be_nil
    end

    it 'cannot remove a nonexistant vote' do
      work_hash = {
          work: {
              category: "book",
              title: "The Pest",
              creator: "I dunno",
              publication_year: "1990",
              description: "John Leguizamo is the Pest"
          }
      }
      post works_path, params: work_hash
      user = User.new(name: 'tester')
      perform_login(user)

      expect {
        delete work_vote_path(work_hash)
      }.wont_differ 'work.votes_button'

      expect(flash[:warning]).wont_be_nil
    end

    it 'cannot remove a vote unless logged in' do
      work = works(:test_album)

      expect {
        delete work_vote_path(work.id)
      }.wont_change work.vote_button

      expect(flash[:warning]).wont_be_nil
    end
  end
end
