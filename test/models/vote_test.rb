require "test_helper"

describe Vote do
  let (:new_user) {
    User.create(username: "user")
  }
  let (:new_work) {
    Work.create(category: "book",
                title: "The Book")
  }
  let (:new_vote) {
    Vote.create(user_id: new_user.id,
                work_id: new_work.id)
  }
  it "can be instantiated" do
    expect(new_vote.valid?).must_equal true
  end
  it "will have the required fields" do
    # Arrange
    new_vote.save
    vote = Vote.first
    # Assert
    expect(Vote.count).must_equal 1
    expect(vote).must_respond_to :user_id
    expect(vote).must_respond_to :work_id
  end

  describe 'relationships' do
    it "can get the information of the user it belongs to" do
      # confirms that object exists and fields match
      expect(new_vote.user).must_equal new_user
      expect(new_vote.user.username).must_equal new_user.username
      expect(new_vote.user_id).must_equal new_user.id
    end
    it "can get the information of the work it belongs to" do
      # confirms that object exists and fields match
      expect(new_vote.work).must_equal new_work
      expect(new_vote.work.title).must_equal new_work.title
      expect(new_vote.work.category).must_equal new_work.category
      expect(new_vote.work_id).must_equal new_work.id
    end
  end

  describe 'validations' do
    it 'prevents multiple votes for a work by the same user' do
      new_vote.save
      copy_vote = Vote.create(user_id: new_user.id,
                              work_id: new_work.id)
      expect(copy_vote.valid?).must_equal false
      expect(copy_vote.errors.messages).must_include :user
      expect(copy_vote.errors.messages[:user]).must_equal ['has already voted for this work']
    end
  end
end
