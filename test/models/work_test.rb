require "test_helper"

describe Work do

  describe "validations" do
    it "is valid when all fields are present" do
      work = Work.new(category: "book", title: "Big Friendship", publication_year: "2020", description: "A book about friendship")
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
      it "returns the most voted and the most recently recreated work" do
        expect(Work.spotlight).must_be_instance_of Work
        expect(Work.spotlight).must_equal works(:hp1)

      end
    end

    describe "top ten" do
      it "returns a list of 10 work objects for books sorted by number of votes then date created" do
        top_ten_books = Work.top_ten("book")
        expect(top_ten_books.length).must_equal 10
        expect(top_ten_books.first).must_be_instance_of Work
        top_ten_books.each do |book|
          expect(book.category).must_equal "book"
        end
        expect(top_ten_books.first).must_equal works(:hp1)
        expect(top_ten_books.last).must_equal works(:DFZ1)
      end

      it "returns a list of work objects for movies sorted by number of votes then date created" do
        top_ten_movies = Work.top_ten("movie")
        expect(top_ten_movies.length).must_equal 4
        expect(top_ten_movies.first).must_be_instance_of Work
        top_ten_movies.each do |work|
          expect(work.category).must_equal "movie"
        end
        expect(top_ten_movies.first).must_equal works(:mulan)
        expect(top_ten_movies.last).must_equal works(:moana)
      end

      it "returns an empty list for albums" do
        album = Work.top_ten("album")
        expect(album.length).must_equal 0
      end
    end

    def single_or_plural_votes
      it "returns a singular 'vote' if there is 1 vote" do
        work = works(:hp2)
        expect(work.single_or_plural_votes).must_equal "1 Vote"
      end

      it "returns a plural 'votes' if there are 0 or 2+ votes" do
        work = works(:hp1)
        expect(work.single_or_plural_votes).must_equal "3 Votes"
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
