require "test_helper"

describe User do
  before do
    @user = users(:user1)
  end

  describe "instantiation" do
    it "can be instantiated" do
      expect(@user.valid?).must_equal true
    end

    it "will have the required fields" do
      expect(@user).must_respond_to :username
      expect(@user).must_respond_to :created_at
    end
  end

  describe "validations" do
    it "is invalid without a username" do
      @user.username = nil
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :username
    end
  end

  describe "relations" do
    it "can have many votes" do
      expect(@user.votes.count).must_equal 2

      expect {
        Vote.create!(work_id: works(:work3).id, user_id: @user.id)
      }.must_differ "@user.votes.count", 1

      @user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it "can have many works through votes" do
      Vote.create!(work_id: works(:work4).id, user_id: @user.id)
      Vote.create!(work_id: works(:work5).id, user_id: @user.id)

      @user.votes.each do |vote|
        voted_work = Work.find_by(id: vote.work_id)
        expect(voted_work).must_be_instance_of Work
      end
    end
  end

end

