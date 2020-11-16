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

end
