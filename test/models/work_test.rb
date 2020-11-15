require "test_helper"

describe Work do

  before do
    @user1 = users(:user1)
    @user2 = users(:user2)
    @user3 = users(:user3)

    @book1 = works(:book1)
    @book2 = works(:book2)
    @book3 = works(:book3)
    @book4 = works(:book4)

    @movie1 = works(:movie1)
    @movie2 = works(:movie2)
    @movie3 = works(:movie3)
    @movie4 = works(:movie4)
    @movie5 = works(:movie5)
    @movie6 = works(:movie6)
    @movie7 = works(:movie7)
    @movie8 = works(:movie8)
    @movie9 = works(:movie9)
    @movie10 = works(:movie10)
    @movie11 = works(:movie11)
    @movie12 = works(:movie12)
  end

  describe "validations" do

    it "is valid when title and category fields are filled" do
      work = Work.first
      result = work.valid?
      expect(result).must_equal true
    end

    it "fails validation with an invalid category" do
      @magazine = Work.new(
          title: "wired magazine",
          creator: "creator",
          description: "a good magazine",
          category: "magazine",
          published: 2020
      )

      result = @magazine.valid?
      expect(result).must_equal false
    end

    it "must have a title" do
      work = Work.first

      work.title = nil
      result = work.valid?
      expect(result).must_equal false
    end

    it "fails validation when the title already exists in same category" do
      @new_movie = Work.new(
          title: @movie1.title,
          category: @movie1.category,
      )
      result = @new_movie.valid?
      expect(result).must_equal false
    end

  end

  describe "categories" do

    it "can produce a list of media for each category" do
      @movies = Work.movies
      @movies.each do |work|
        expect(work.category).must_equal "movie"
      end

      @books = Work.books
      @books.each do |work|
        expect(work.category).must_equal "book"
      end

      @albums = Work.albums
      @albums.each do |album|
        expect(album.category).must_equal "album"
      end
    end
  end

  describe "top 10" do

    it "can produce a list of 10 movies for top 10" do
      @top_movies = Work.top_movies
      @top_movies.each do |work|
        expect(work.category).must_equal "movie"
      end

      expect(@top_movies.length).must_equal 10
      expect(@top_movies.first.title).must_equal "The Goonies"
    end

    it "can produce a list of less than 10 books for top 10, if category has less than 10" do
      @top_books = Work.top_books
      @top_books.each do |work|
        expect(work.category).must_equal "book"
      end

      expect(@top_books.length).must_equal 4
      expect(@top_books.first.title).must_equal "Circe"
    end

    it "can produce a list of 0 albums when no albums in db" do
      @top_albums = Work.top_albums
      expect(@top_albums.length).must_equal 0
    end

    it "can sort by votes count" do
      @top_books = Work.top_books

      expect(@top_books.first.votes.count).must_equal 4
      expect(@top_books[1].votes.count).must_equal 2
      expect(@top_books.last.votes.count).must_equal 0

      @top_movies = Work.top_movies

      expect(@top_movies.first.votes.count).must_equal 3

    end

    it "can sort ties alphabetically by title" do
      @top_movies = Work.top_movies

      expect(@top_movies[4].title).must_equal "AAAAAA"
      expect(@top_movies[4].votes.count).must_equal 0

      expect(@top_movies.last.title).must_equal "MMMM"
      expect(@top_movies.last.votes.count).must_equal 0
    end
  end

  describe "spotlight" do
    it "can find the highest voted work" do
      @spotlight = Work.spotlight
      expect(@spotlight.title).must_equal "Circe"
    end
  end
end