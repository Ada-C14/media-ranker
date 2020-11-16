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
      # Act
      result = @work.valid?
      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it 'is invalid without a description' do
      # Arrange
      @work.category = nil
      # Act
      result = @work.valid?
      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :description
    end

    it "is valid if title is unique in the scope of category" do
      # Arrange
      @work.save
      @diff_work = Work.new(title: @work.title, category: 'book')
      # Act
      result = @diff_work.valid?
      # Assert
      expect(result).must_equal true
    end
  end
end
