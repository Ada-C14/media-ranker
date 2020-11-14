require "test_helper"

describe User do
  describe "relations" do
    before do
      @lathe = works(:lathe)
      @user = users(:testuser)
    end

    it "has votes" do
      vote = Vote.create!(user_id: @user.id, work_id: @lathe.id)
      expect(@user).must_respond_to :votes
      @lathe.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
end
