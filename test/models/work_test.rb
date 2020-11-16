require "test_helper"

describe Work do
  describe "validations" do
    before do
      # Arrange
      @work = Work.new(category: "book", title: "The Cat in the Hat", creator: "Dr. Seuss", publication_year: 1957, description: "anthropomorphic cat")
    end

    it "is valid when all fields are present" do
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it "is invalid without a title" do
      # Arrange
      @work.title = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it "is invalid without a creator" do
      # Arrange
      @work.creator = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :creator
    end

    it "is invalid without a publication year" do
      # Arrange
      @work.publication_year = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :publication_year
    end

    it "is invalid without a description" do
      # Arrange
      @work.description = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :description
    end
  end
end
