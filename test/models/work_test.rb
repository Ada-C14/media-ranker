require "test_helper"

describe Work do

  describe "relationships" do
    it "has votes" do
      book = works(:book_one)

      expect(book).must_respond_to :votes
      book.votes.each do |vote|
        expect(vote).must_be_kind_of Vote
      end
    end

    it "has voting users" do
      book = works(:book_one)

      expect(book).must_respond_to :users
      book.users.each do |user|
        expect(user).must_be_kind_of User
      end
    end
  end

  describe "validations" do
    it "must have a title" do
      # Arrange
      work = Work.first
      work.title = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end
    it "must have a description" do
      # Arrange
      work = Work.first
      work.description = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :description
      expect(work.errors.messages[:description]).must_equal ["can't be blank"]
    end
    it "must have a publication date" do
      # Arrange
      work = Work.first
      work.publication_date = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :publication_date
      expect(work.errors.messages[:publication_date]).must_equal ["can't be blank", "is not a number"]

    end
    it "must have a creator" do
      # Arrange
      work = Work.first
      work.creator = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :creator
      expect(work.errors.messages[:creator]).must_equal ["can't be blank"]
    end
    it "must have a category" do
      # Arrange
      work = Work.first
      work.category = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["can't be blank", "category must be a movie, book or album"]

    end
    it "publication date must be a number" do
      # Arrange
      work = Work.first
      work.publication_date = 'December 1975'

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :publication_date
      expect(work.errors.messages[:publication_date]).must_equal ["is not a number"]
    end
    it "category must be a movie, book or album" do
      # Arrange
      work = Work.first
      work.category = 'podcast'

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["category must be a movie, book or album"]

    end
  end

end
