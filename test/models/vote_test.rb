require "test_helper"

describe Vote do
  it 'is valid when all fields are present' do
    # Arrange
    vote = votes(:user1_work3)
    p vote.valid?
    # Act
    result = vote.valid?

    # Assert
    expect(result).must_equal true
  end

  it 'is invalid without a user or a work' do
    # Arrange
    vote_no_user = votes(:user1_work3)
    vote_no_user.user_id = nil

    vote_no_work = votes(:user1_work2)
    vote_no_work.work_id = nil
  
    # Act
    result_user = vote_no_user.valid?
    result_work = vote_no_work.valid?
  
    # Assert
    expect(result_user).must_equal false
    expect(vote_no_user.errors.messages).must_include :user_id

    expect(result_work).must_equal false
    expect(vote_no_work.errors.messages).must_include :work_id
  end

  it 'is invalid with a non-unique vote' do
    # Arrange
    unique_vote = Vote.create!(user_id: users(:john).id, work_id: works(:kreb_album).id, date: "Nov 13, 2020")
    votes(:user1_work3).user_id = unique_vote.user_id
    votes(:user1_work3).work_id = unique_vote.work_id

    # Act
    result = votes(:user1_work3).valid?

    # Assert
    expect(result).must_equal false
    expect(votes(:user1_work3).errors.messages).must_include :user_id
    expect(votes(:user1_work3).errors.messages[:user_id].include?(": has already voted for this work")).must_equal true
  end

  describe 'relations' do
    it "has a work" do
      vote = votes(:user1_work2)
      expect(vote.work_id).must_equal works(:joe_book).id
    end

    it "has an user" do
      vote = votes(:user1_work3)
      expect(vote.user_id).must_equal users(:john).id
    end
  end
end
