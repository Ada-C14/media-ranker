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
  end
end
