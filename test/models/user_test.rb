require "test_helper"

describe User do
  let (:new_user) {
    User.new(username: "user")
  }
  it "can be instantiated" do
    # Assert
    expect(new_user.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_user.save
    user = User.first
    # Assert
    expect(user).must_respond_to :username
  end

  describe "relationships" do
    before do
      new_user.save
    end
    it "can have many votes" do
      # arrange
      new_work = Work.create(category: "album", title: "The Album")
      new_work2 = Work.create(category: "album", title: "The Other Album")
      vote_1 = Vote.create(user_id: new_user.id, work_id: new_work.id)
      vote_2 = Vote.create(user_id: new_user.id, work_id: new_work2.id)
      # Assert
      expect(new_user.votes.count).must_equal 2
      expect(vote_1.work).must_equal new_work
      expect(vote_2.work).must_equal new_work2
      new_user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
        expect(vote.user_id).must_equal new_user.id
      end
    end
    it "can get information of works the user voted for" do
      # arrange
      new_work = Work.create(category: "album", title: "The Album")
      new_work2 = Work.create(category: "album", title: "The Other Album")
      vote_1 = Vote.create(user_id: new_user.id, work_id: new_work.id)
      vote_2 = Vote.create(user_id: new_user.id, work_id: new_work2.id)
      # Assert
      expect(new_user.works.count).must_equal 2
      # check info
      expect(new_user.works.find_by(title: "The Album")).must_equal new_work
      expect(new_user.works.find_by(title: "The Other Album")).must_equal new_work2
      new_user.works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end

  end

  describe "validations" do
    it "must have a username" do
      # Arrange
      new_user.username = nil

      # Assert
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :username
      expect(new_user.errors.messages[:username]).must_equal ["can't be blank"]
    end
  end
end
