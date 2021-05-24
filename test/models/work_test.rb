require "test_helper"

describe Work do
  describe "validations" do
    it "instance of Work with valid fields passes" do
      work = works(:the_dude)
      expect(work.valid?).must_equal true
    end

    it "must have a title" do
      work = works(:the_dude)
      work.title = nil
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it "title must be unique" do
      work1 = works(:the_dude)
      work2 = works(:moonrise)
      work1.title = work2.title

      expect(work1.valid?).must_equal false
      expect(work1.errors.messages).must_include :title
    end

    it "doesn't need a description" do
      work = works(:the_dude)
      work.description = nil
      expect(work.valid?).must_equal true
    end

    it "doesn't need a publication_year" do
      work = works(:the_dude)
      work.publication_year = nil
      expect(work.valid?).must_equal true
    end

    it "publication year doesn't need to be numeric" do
      work = works(:the_dude)
      work.publication_year = "Y1892"
      expect(work.valid?).must_equal true
    end

    it "publication year doesn't need to be positive" do
      work = works(:the_dude)
      work.publication_year = -1
      expect(work.valid?).must_equal true
    end

    it "doesn't need a creator" do
      work = works(:the_dude)
      work.creator = nil
      expect(work.valid?).must_equal true
    end

    it "doesn't need a category" do
      work = works(:the_dude)
      work.category = nil
      expect(work.valid?).must_equal true
    end
  end

  describe "relations" do
    it "Work can have many Votes" do
      work = works(:work3)
      expect(work.votes.count).must_equal 3
    end

    it "Work can have 0 Votes" do
      work = works(:work6)
      expect(work.votes.count).must_equal 0
    end

    it "Work can have many Users through Votes" do
      work = works(:work3)
      expect(work.users.count).must_equal 3
    end

    it "Work can have 0 Works through Votes" do
      work = works(:work11)
      expect(work.users.count).must_equal 0
    end
  end

  describe "filter method" do
    it "filters by category" do
      expect(Work.filter_category("movie").length).must_equal 3
      expect(Work.filter_category("book").length).must_equal 11
      expect(Work.filter_category("album").length).must_equal 0
    end
  end

  describe "category methods" do
    it "selects movies" do
      expect(Work.movies.length).must_equal 3
    end

    it "selects books" do
      expect(Work.books.length).must_equal 11
    end

    it "selects albums" do
      expect(Work.albums.length).must_equal 0
    end
  end

  describe "spotlight" do
    it "can select work" do
      expect(Work.spotlight.title).must_equal "work3 title"
    end

    it "if there is a tie" do
      user = users(:user10)
      work = works(:work4)

      vote9 = Vote.create(user: user, work: work)
      expect(vote9.valid?).must_equal true
      expect(works(:work4).votes.count).must_equal 3

      expect(work.votes.count).must_equal works(:work3).votes.count
      expect(Work.spotlight.title).must_equal "work3 title"
    end

    it "if there are 0 works" do
      Work.destroy_all
      expect(Work.spotlight).must_be_nil
    end
  end

  describe "top_ten" do
    it "if there are 10 works or more" do
      books = Work.books
      expect(books.count).must_equal 11
      top_ten_book = Work.top_ten("book")

      expect(top_ten_book.length).must_equal 10
    end

    it "if there are between 0 and 10 works" do
      movies = Work.movies
      expect(movies.count).must_equal 3
      top_ten_movie = Work.top_ten("movie")

      expect(top_ten_movie.length).must_equal 3
    end

    it "if there are 0 works" do
      albums = Work.albums
      expect(albums.count).must_equal 0
      top_ten_album = Work.top_ten("album")

      expect(top_ten_album.length).must_equal 0
    end
  end

  describe "vote date with conversion" do
    it "returns date_voted on for existing work" do
      vote = votes(:vote1)
      expect(Work.vote_date(vote)).must_equal "Nov 12, 2020"
    end
  end
end
