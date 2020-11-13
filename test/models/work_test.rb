require "test_helper"

describe Work do

  describe "validations" do
    it "is valid when all fields are present" do
      work = Work.new(category: "book", title: "Harry Potter and the Prisoner of Azkaban", publication_year: "2000", description: "Harry return to hogwarts and is reunited with his Godfather")
      result = work.valid?
      expect(result).must_equal true
    end

    it "must have a category" do
      result = works(:hp1)
      result[:category] = nil
      expect(result.valid?).must_equal false
    end

    it "must have a title" do
      result = works(:hp1)
      result[:title] = nil
      expect(result.valid?).must_equal false
    end

    it "must have a unique title" do
      book = works(:hp1)
      book_copy = Work.new(category: "book", title: book.title)
      expect(book_copy.valid?).must_equal false
    end
  end

  describe "custom methods" do
    describe "spotlight" do
      it "returns a random work object" do
        expect(Work.spotlight).must_be_instance_of Work
      end
    end

    describe "top ten" do
      it "returns a list of 10 work objects for books" do
        top_ten_books = Work.top_ten("book")
        expect(top_ten_books.length).must_be :<=, 10
        expect(top_ten_books.first).must_be_instance_of Work
        top_ten_books.each do |book|
          expect(book.category).must_equal "book"
        end
      end
    end
  end

  describe "relationships" do
    it "can have many users through votes" do
      work = works(:hp1)
      expect(work.users.length).must_equal 3
      expect(work.users.first).must_equal users(:harry)
      expect(work.users.last).must_equal users(:justin)
    end

    it "can have many votes" do
      work = works(:hp1)
      expect(work.votes.length).must_equal 3
    end
  end
end
