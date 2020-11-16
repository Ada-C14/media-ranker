require "test_helper"

describe Vote do
  describe 'validations' do
    before do
      # Arrange
      @vote = votes(:vote_movie)
    end

    it 'is valid when all fields are present' do
      # Act
      result = @vote.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is not valid when fields are not present' do
      @vote = Vote.new()


      result = @vote.valid?

      expect(result).must_equal false
    end
  end
  describe 'relationships' do
    it 'belongs to a work' do
    work = works(:movie)
    user = users(:test_user)
    @vote = Vote.new(user.id, work.id)

    expect(@vote.work_id).must_be_same_as work.id
    end
    it 'belongs to a user' do
      work = works(:movie)
      user = users(:test_user)
      @vote = Vote.new(user.id, work.id)

      expect(vote.user_id).must_be_same_as user.id
    end
  end
end
