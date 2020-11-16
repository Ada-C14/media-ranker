require "test_helper"

describe User do
  before do
    @new_user = User.new(username: "tester")
  end

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
      album = works(:album)
      book = works(:book)
      first_vote = Vote.create(user_id: @new_user.id, work_id: album.id)
      second_vote = Vote.create(user_id: @new_user.id, work_id: book.id)

      expect(@new_user.votes.count).must_equal 2
      @new_user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
        expect(vote.user_id).must_equal @new_user.id
      end

      expect(@new_user.votes.first.work_id).must_equal album.id
      expect(@new_user.votes.last.work_id).must_equal book.id

      expect(@new_user.works.count).must_equal 2
      @new_user.works.each do |work|
        expect(work).must_be_instance_of Work
      end

      expect(@new_user.works.first).must_equal album
      expect(@new_user.works.last).must_equal book
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
