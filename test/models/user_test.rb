require "test_helper"

describe User do
  before do
    @new_user = User.new(username: "tester")
  end

  let (:work_1) {
    Work.create(category: "album", title: "Test Album", creator: "Some musician", publication_year: 2020, description: "First work")
  }

  let (:work_2) {
    Work.create(category: "book", title: "Test Book", creator: "Some author", publication_year: 2020, description: "Second work")
  }

  it "can be instantiated" do
    expect(@new_user.valid?).must_equal true
  end

  it "will have the required fields" do
    @new_user.save
    user = User.first

    expect(user).must_respond_to :username
  end

  describe "relationships" do
    it "can have many votes and many works through votes" do
      @new_user.save
      vote_1 = Vote.create(user_id: @new_user.id, work_id: work_1.id)
      vote_2 = Vote.create(user_id: @new_user.id, work_id: work_2.id)

      expect(@new_user.votes.count).must_equal 2
      @new_user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
        expect(vote.user_id).must_equal @new_user.id
      end

      expect(@new_user.votes.first.work_id).must_equal work_1.id
      expect(@new_user.votes.last.work_id).must_equal work_2.id

      expect(@new_user.works.count).must_equal 2
      @new_user.works.each do |work|
        expect(work).must_be_instance_of Work
      end

      expect(@new_user.works.first.id).must_equal work_1.id
      expect(@new_user.works.last.id).must_equal work_2.id
    end
  end

  describe "validations" do
    it "must have a username" do
      @new_user.username = nil

      expect(@new_user.valid?).must_equal false
      expect(@new_user.errors.messages).must_include :username
      expect(@new_user.errors.messages[:username]).must_equal ["can't be blank"]
    end
  end
end
