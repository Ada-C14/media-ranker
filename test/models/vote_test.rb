require "test_helper"

describe Vote do
  before do
    @work2 = Work.create(category: "book", title: "test book3", creator: "test3", publication_year: 2012, description: "test3")
    @user = User.create(username: "test2")
    @vote2 = Vote.create(work_id: @work2[:id],user_id: @user[:id])
  end
  it "can be created with accurate attributes" do
    expect(@work2.votes.count).must_equal 1
    expect(@user.votes.count).must_equal 1
  end

  describe "validations" do
    it "wont create a vote if a user has already voted for that work" do
      @vote = Vote.create(work_id: @work2[:id],user_id: @user[:id])

      expect(@vote.valid?).must_equal false
    end

    it "wont create a vote if missing a field" do
      @vote = Vote.create(user_id: @user[:id])

      expect(@vote.valid?).must_equal false
    end
  end

  describe "relationships" do
    it "belongs to works and users" do
      expect(@vote2.work_id).must_equal @work2.id
      expect(@vote2.user_id).must_equal @user.id
    end
  end
end
