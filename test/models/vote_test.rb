require "test_helper"

describe Vote do
  it "can be instantiated" do
    expect(votes(:vote).valid?).must_equal true
  end
  it "will have the required fields" do
    # Arrange
    vote = Vote.first
    # Assert
    expect(Vote.count).must_equal 2
    expect(vote).must_respond_to :user_id
    expect(vote).must_respond_to :work_id
  end

  describe 'relationships' do
    it "can get the information of the user it belongs to" do
      # confirms that object exists and fields match
      expect(votes(:vote).user).must_equal users(:user)
      expect(votes(:vote).user.username).must_equal users(:user).username
      expect(votes(:vote).user_id).must_equal users(:user).id
    end
    it "can get the information of the work it belongs to" do
      # confirms that object exists and fields match
      expect(votes(:vote).work).must_equal works(:book)
      expect(votes(:vote).work.title).must_equal works(:book).title
      expect(votes(:vote).work.category).must_equal works(:book).category
      expect(votes(:vote).work_id).must_equal works(:book).id
    end
  end

  describe 'validations' do
    it 'prevents multiple votes for a work by the same user' do
      copy_vote = Vote.create(user_id: votes(:vote).user_id,
                              work_id: votes(:vote).work_id)
      expect(copy_vote.valid?).must_equal false
      expect(copy_vote.errors.messages).must_include :user
      expect(copy_vote.errors.messages[:user]).must_equal ['has already voted for this work']
    end
  end
end
