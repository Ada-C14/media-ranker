require "test_helper"

describe Vote do
  before do
    @work = works(:test_work)
    @user = User.create!(name: "test user")
    @vote = Vote.create!(user_id: @user.id, work_id: @work.id)
  end

  describe "instantiation" do
    it "can be instantiated" do
      expect(@vote.valid?).must_equal true
    end

    it "will have the required fields" do
      [:user_id, :work].each do |field|
        expect(@vote).must_respond_to field
      end
    end
  end

  describe "relations" do
    it "belongs to a user" do
      expect(@vote.user_id).must_equal @user.id
      expect(@vote.user).must_equal @user
    end

    it "belongs to a work" do
      expect(@vote.work_id).must_equal @work.id
      expect(@vote.work).must_equal @work
    end
  end
end
