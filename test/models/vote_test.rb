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

  describe "validations" do
    before do
      @lathe = works(:lathe)
      @user = users(:testuser)
    end

    it "limits user to one vote per work" do
      vote = Vote.create!(user_id: @user.id, work_id: @lathe.id)
      expect(vote.valid?).must_equal true
      vote = Vote.create(user_id: @user.id, work_id: @lathe.id)
      expect(vote.valid?).must_equal false
      expect(vote.errors.messages).must_include :user
    end

    it "does not allow a vote to be created without logging in" do
      user = nil
      vote = Vote.create(user_id: user, work_id: @lathe.id)
      expect(vote.valid?).must_equal false
      expect(vote.errors.messages).must_include :user
    end
  end
end
