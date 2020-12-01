require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  describe "validations" do
    before do
      @work = works(:work1)
    end 

    it "is valid when all fields are present" do 
      @work.valid?.must_equal true
    end

    it "is not valid when there is no category" do
      @work.category = nil
      expect(@work.valid?).must_equal false
    end

    it "is not valid when there is no title" do
      @work.title = nil
      expect(@work.valid?).must_equal false
    end 

    it "has default of 0 votes" do
      work = Work.create(title: "test", category: "book")
      expect(work).must_respond_to :vote_count
      expect(work.vote_count).must_equal 0
    end

    it "updates vote count when votes are cast" do 
      work = Work.create(title: "test2", category: "book")
      vote1 = Vote.create(user: users(:user1), work: work)
      expect(work.vote_count).must_equal 1
      vote2 = Vote.create(user: users(:user2), work: work)
      expect(work.vote_count).must_equal 2
    end
  end

  describe "spotlight" do
    it "spotlight is an instance of work" do
      @works = Work.all
      result = @works.media_spotlight
      expect(result).must_be_instance_of Work
    end

    it "spotlight is work that has the most votes" do
      @works = Work.all
      result = @works.media_spotlight
      expect(result.title).must_equal "title3"
    end
  end

  describe "top ten" do
    before do
      @works = Work.all
    end

    it "creates array of books" do
      result = @works.top_ten_books
      expect(result).must_be_instance_of Array
    end

    it "creates array of albums" do
      result = @works.top_ten_albums
      expect(result).must_be_instance_of Array
    end

    it "correctly identifies category as book" do
      result = @works.top_ten_books
      result.each do |book|
        expect(book.category).must_equal "book"
      end
    end

    it "correctly identifies category as album" do
      result = @works.top_ten_albums
      result.each do |book|
        expect(book.category).must_equal "album"
      end
    end

    it "returns max of 10 items" do
      books = @works.top_ten_books
      expect(books.length).must_equal 9

      Work.create(title: "title11", category: "book")
      books = @works.top_ten_books
      expect(books.length).must_equal 10

      Work.create(title: "title12", category: "book")
      books = @works.top_ten_books
      expect(books.length).must_equal 10
    end
  end

  describe "sort" do
    before do
      @works = Work.all
    end

    it "puts work with highest votes in category first" do
      @work = works(:work2)
      result = @works.top_ten_books.first
      expect(result).must_equal @work
    end
  end 
end
