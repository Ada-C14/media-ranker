require "test_helper"

# Add Relations Tests in Wave 2
# New? Create?

describe Work do
  before do
    @work = works(:book1)
  end

  describe "validations" do
    it "can be instantiated and is valid when all required fields are present" do
      # Act
      created_work = @work.valid?

      # Assert
      expect(created_work).must_equal true
    end

    it "is invalid without title" do
      # Arrange
      @work.title = nil

      #Act
      titleless_work = @work.valid?

      # Assert
      expect(titleless_work).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it "is invalid without category" do
      # Arrange
      @work.category = nil

      #Act
      categoryless_work = @work.valid?

      # Assert
      expect(categoryless_work).must_equal false
      expect(@work.errors.messages).must_include :category
    end
  end

  describe "relationships" do
    it "has a vote" do
      # Arrange movie with single vote in works.yml
      work = works(:movie2)

      # Assert that movie2 has 1 votes in votes.yml
      expect(work.votes.count).must_equal 1
    end

    it "has multiple votes" do
      # Arrange book with 2 votes in works.yml
      work = works(:book2)

      # Assert
      expect(work.votes.count).must_equal 2
    end
  end

  describe "custom methods" do
    it "returns a spotlight work" do

      expect(Work.spotlight).must_be_instance_of Work
    end

    it "returns nil for spotlight when database is empty" do
      Work.delete_all

      expect(Work.count).must_equal 0
      expect(Work.spotlight).must_be_nil
    end

    it "returns an array for top 10" do
      top_books = Work.top_ten("book")

      expect(top_books).must_be_instance_of Array
    end

    it "returns an array of 10 albums for top 10 method" do
      top_books = Work.top_ten("album")

      expect(top_books.length).must_equal 10
    end
  end
end
