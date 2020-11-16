require "test_helper"

describe User do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  describe "validations" do
    before do
      @user = User.new(name: "test user")
    end

    it "is valid when all fields are present" do
      result = @user.valid?
      expect(result).must_equal true
    end

    it "is invalid without a name" do
      @user.name = nil
      result = @user.valid?
      expect(result).must_equal false
    end

  end

  describe "relationships" do
    before do
      @work = Work.create(category: "music", title: "fake title", creator: "fake creator", description: "fake music", publication_year: 1999)
      @user = User.create(name: "fake user")

      @vote = Vote.create(user_id: @user.id , work_id: @work.id)
      @vote = Vote.create(user_id: @user.id , work_id: @work.id)
    end

    it "may have many votes" do
      expect(@user.votes.count).must_equal 2
    end
  end
end
