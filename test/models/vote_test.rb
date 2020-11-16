require "test_helper"

describe Vote do
  describe "validations" do
    before do
      @work = Work.create(category: "fake music", title: "fake title", creator: "fake creator", description: "fake music", publication_year: 2013)
      @user = User.create(name: "fake user")
      @vote = Vote.create(user_id: @user.id , work_id: @work.id)
    end

    it "is valid when all fields are present" do
      result = @vote.valid?
      expect(result).must_equal true
    end

    it "is invalid without a user_id" do
      @vote.user_id = nil
      result = @vote.valid?
      expect(result).must_equal false
    end

    it "is invalid without a work_id" do
      @vote.work_id = nil
      result = @vote.valid?
      expect(result).must_equal false
    end
  end

  describe "relationships" do
    it "must have a user" do
      vote = votes(:vote1)
      _(vote.user).must_equal users(:ana)
    end

    it "must have a work" do
      vote = votes(:vote1)
      _(vote.work).must_equal works(:bebop)
    end

    it "sets the user" do
      vote = Vote.new(user_id: "10", work_id: "20")
      vote.user = users(:ana)
      _(vote.user_id).must_equal users(:ana).id
    end

    it "sets the work" do
      vote = Vote.new(user_id: "10", work_id: "20")
      vote.work = works(:bebop)
      _(vote.work_id).must_equal works(:bebop).id
    end
  end


end

