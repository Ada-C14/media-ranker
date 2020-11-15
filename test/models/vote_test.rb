require "test_helper"

describe Vote do
  before do
    @work = works(:test_work)
    @user = User.create!(name: "test user")
    @vote = Vote.create!(user_id: @user.id, work_id: @work.id)
  end

  let (:hard_coded_time){
    Time.parse("2008-06-21 13:30:00 UTC")
    }

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

    it "cannot be duplicated for a given user/work" do
      result = Vote.create(user_id: @user.id, work_id: @work.id)
      expect(result.valid?).must_equal false
    end
  end

  describe "format created at time" do

    it "can format created at time" do
      @vote.created_at = hard_coded_time
      expect(@vote.format_created_at_time).must_equal "Jun 21, 2008"
    end
  end

end
