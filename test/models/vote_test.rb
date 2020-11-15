require "test_helper"

describe Vote do
  describe 'validations' do
    before do
      # Arrange
      @user = User.new(username: 'testperson')
      @work = Work.new(category: 'album', title: 'test', creator: 'testy mc testerson', publication_year: "1900", description: 'a testy album' )
      @vote = Vote.new(user_id: @user.id, work_id: @work.id)
    end

    it 'is valid when all fields are present' do
      # Act
      result = @vote.valid?

      # Assert
      expect(result).must_equal true
    end
  end
end
