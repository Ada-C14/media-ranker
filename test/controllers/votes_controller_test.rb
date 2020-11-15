require "test_helper"

describe VotesController do

  let (:vote_hash) {
    {
        vote: {
            user_id: @user.id,
            work_id: params[:work_id]
        }
    }
  }

  it "create: won't create vote and will redirect if a user is not signed in" do
    expect { post votes_path, params:  }.wont_change 'Vote.count'
  end

  it 'create: will redirect and flash message if user tries to vote for same work multiple time' do

  end

  it 'create: will create a vote for a new upvote work' do

  end

  it 'create: will redirect back upon successful creation of vote' do

  end
end
