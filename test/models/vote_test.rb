require "test_helper"

describe Vote do
  describe "relations" do
    before do
      @lathe = works(:lathe)
      @user = users(:testuser)
    end

    it "belongs to users" do
      vote = Vote.create!(user_id: @user.id, work_id: @lathe.id)
      expect(vote).must_respond_to :user
      expect(vote.user).must_be_instance_of User
    end

    it "belongs to users" do
      vote = Vote.create!(user_id: @user.id, work_id: @lathe.id)
      expect(vote).must_respond_to :work
      expect(vote.work).must_be_instance_of Work
    end
  end
end
