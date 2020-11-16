require "test_helper"

describe Work do
  before do
    @new_work = Work.new(category: "movie", title: "Test Movie", creator: "Some director", publication_year: 2020, description: "NA")
  end

  let (:user1) {
    User.create(username: "user1")
  }

  let (:user2) {
    User.create(username: "user2")
  }

  it "can be instantiated" do
    expect(@new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    @new_work.save
    work = Work.first

    [:category, :title, :creator, :publication_year, :description].each do |field|
      expect(work).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many votes and many users through votes" do
      @new_work.save
      vote_1 = Vote.create(work_id: @new_work.id, user_id: user1.id)
      vote_2 = Vote.create(work_id: @new_work.id, user_id: user2.id)

      expect(@new_work.votes.count).must_equal 2
      @new_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
        expect(vote.work_id).must_equal @new_work.id
      end

      expect(@new_work.votes.first.user_id).must_equal user1.id
      expect(@new_work.votes.last.user_id).must_equal user2.id

      expect(@new_work.users.count).must_equal 2
      @new_work.users.each do |user|
        expect(user).must_be_instance_of User
      end

      expect(@new_work.users.first.id).must_equal user1.id
      expect(@new_work.users.last.id).must_equal user2.id
    end
  end

  describe "validations" do
    it "must have a category" do
      @new_work.category = nil

      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :category
      expect(@new_work.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "must have a title" do
      @new_work.title = nil

      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :title
      expect(@new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end

  describe "custom methods" do
    describe "sort_by_votes" do
      # sorts two works properly?
      # first work is one with most votes
      # last is one with least votes
      #
      # first two have zero works
      # get minimum vote count, and verify that last element has that number of votes
    end

    describe "top_10" do
      # create 11 works
      # vote for all but one
      # top_10 see if it excludes the one i didn't vote for
      #
      # if there's no media in category
      # less than 10 media
      # only less than 10 of category, make sure it's of that category, are there exactly 5 results
      #
      # more than 10 media with equivalent rankings
      # what about media with same votes? is there tie breaker?
    end

    describe "spotlight" do

    end
  end
end
