require "test_helper"

describe VotesController do

  let (:user) { User.first }

  let (:vote_hash) {
    {
        vote: {
            user_id: User.first.id,
            work_id: works(:no_dream).id
        }
    }
  }

  let (:invalid_vote_hash) {
    {
        vote: {
            user_id: Vote.first.user_id,
            work_id: Vote.first.work_id
        }
    }
  }


  it "create: won't create vote and will redirect if a user is not signed in" do
    expect { post work_votes_path(works(:no_dream).id), params: vote_hash }.wont_change 'Vote.count'
    must_respond_with :redirect
    expect(user.votes_count).must_equal 2
  end

  it 'create: will redirect and flash message if user tries to vote for same work multiple time' do
    login(user.username)
    expect { post work_votes_path(works(:ctrl).id), params: invalid_vote_hash }.wont_change 'Vote.count'
    must_respond_with :redirect
    expect(user.votes_count).must_equal 2
  end

  it 'create: will create a vote for a new upvote work and redirect' do
    login(user.username)
    expect { post work_votes_path(works(:no_dream).id), params: vote_hash }.must_change 'Vote.count', 1
    must_respond_with :redirect
    expect(user.votes.count).must_equal 3
  end
end
