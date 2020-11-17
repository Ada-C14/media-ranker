require "test_helper"

describe Work do
  describe 'validations' do
    before do
      # Arrange
      @work = Work.new(category: 'album', title: 'Nevermind')
    end

    it 'is valid when all fields are present' do
      # Act
      result = @work.valid?
      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a title' do
      # Arrange
      @work.title = nil
      # Assert
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages.include?(:title)).must_equal true
    end

    it 'is invalid when title is not unique' do
      Work.create(title: @work.title, creator: @work.creator)
      # Assert
      expect(@work.valid?).must_equal false
    end
  end
end
