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
end
