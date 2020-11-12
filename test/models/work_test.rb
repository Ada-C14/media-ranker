require "test_helper"

describe Work do
  describe "validations" do

    before do # should i put these into a .yml file?
    @test_book = Work.new(
        title: "test_book",
        creator: "test_author",
        description: "a good book",
        category: "book",
        published: 2020
    )

    @test_movie = Work.new(
        title: "test movie",
        creator: "test moviemaker",
        description: "a good movie",
        category: "movie",
        published: 2020
    )

    @test_album = Work.new(
        title: "test_album",
        creator: "test_musician",
        description: "a good album",
        category: "album",
        published: 2020
    )
    end

    it "is valid when all fields are filled" do
      result = @test_book.valid?
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

    it "fails validation when any required text field is not present" do
      @test_album.title = nil
      result = @test_album.valid?
      expect(result).must_equal false

      @test_movie.creator = nil
      result = @test_movie.valid?
      expect(result).must_equal false

      @test_book.description = nil
      result = @test_book.valid?
      expect(result).must_equal false
    end


    it "fails validation when the title already exists" do
      skip
      @new_movie = Work.new(
          title: @test_movie.title,
          creator: @test_movie.creator,
          description: @test_movie.description,
          category: @test_movie.category,
          published: @test_movie.published
      )
      result = @new_movie.valid?
      expect(result).must_equal false
    end

  end

  describe "categories" do

    it "can produce a list of media for each category" do
      @movies = Work.movies
      @movies.each do |movie|
        expect.(movie.category).must_equal "movie"
      end

      @books = Work.books
      @books.each do |book|
        expect.(book.category).must_equal "book"
      end

      @albums = Work.albums
      @albums.each do |album|
        expect.(album.category).must_equal "album"
      end
    end
  end

  describe "top 10" do

    it "(Wave 1) can produce a random list of up to 10 books for top_books" do
      @top_books = Work.top_books
      @top_books.each do |book|
        expect.(book.category).must_equal "book"
      end

      if Work.books.length < 10
        expect(@top_books.length).must_equal Work.books.length
      else
        expect(@top_books.length).must_equal 10
      end
    end

    it "(Wave 1) can produce a random list of up to 10 movies for top_movies" do
      @top_movies = Work.top_movies
      @top_movies.each do |movie|
        expect.(movie.category).must_equal "movie"
      end

      if Work.movies.length < 10
        expect(@top_movies.length).must_equal Work.movies.length
      else
        expect(@top_movies.length).must_equal 10
      end
    end

    it "(Wave 1) can produce a random list of up to 10 albums for top_albums" do
      @top_albums = Work.top_albums
      @top_albums.each do |album|
        expect.(album.category).must_equal "album"
      end

      if Work.albums.length < 10
        expect(@top_albums.length).must_equal Work.albums.length
      else
        expect(@top_albums.length).must_equal 10
      end
    end
  end
end