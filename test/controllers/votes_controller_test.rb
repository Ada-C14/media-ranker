require "test_helper"

describe VotesController do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  # describe "create" do
  #   it "can create a new vote with valid information and redirect" do
  #
  #     work = works(:gods)
  #     user = users(:ron)
  #
  #
  #     expect {
  #       post work_votes_path(work.id), params: { work_id: work.id, user_id: user.id }
  #     }.must_change "work.votes.count", 1 #come back if time, this isn't changing for some reason, not logged in... but haven't been able to corectly perform login
  #
  #     new_vote = Vote.last
  #     expect(work.votes.count).wont_be_nil
  #     expect(work.users.count).wont_be_nil
  #     expect(new_vote.work_id).must_equal work.id
  #     expect(new_vote.user_id).must_equal user.id
  #     expect{flash[:success]}.must_equal "Successfully upvoted!"
  #
  #     expect(new_vote.driver.available).must_equal false
  #
  #     must_respond_with :redirect
  #   end
  #
  #   it "won't create an invalid vote if user already voted on work" do
      # driver.available = false
      # driver.save
      #
      # # Act-Assert
      # expect {
      #   post passenger_trips_path(passenger.id)
      # }.wont_change "Trip.count"
      #
      # must_redirect
  #   end
  # end
end
