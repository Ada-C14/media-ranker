require "test_helper"

describe Work do
  describe 'validations' do
    before do
      @work = Work.new(
          category: "book",
          title: "Test Book",
          creator: "Test Author",
          publication_year: 2020,
          description: "A test description"
      )
    end

    it 'is valid when the required fields are present' do
      result = @work.valid?
      expect(result).must_equal true
    end

    it 'is invalid without a title' do
      @work.title = nil

      result = @work.valid?

      expect(result).must_equal false
    end

    it 'is invalid without a category' do
      @work.category = nil

      result = @work.valid?

      expect(result).must_equal false
    end

    it 'is invalid without a date' do
      @work.publication_year = nil

      result = @work.valid?

      expect(result).must_equal false
    end

    it 'is invalid without a valid date' do
      @work.publication_year = 3000

      result = @work.valid?

      expect(result).must_equal false
    end
  end

  describe "spotlight" do
    it "returns a pseudorandomly selected work" do
      featured_work = Work.spotlight

      expect(featured_work).must_be_instance_of Work
    end

    it "returns nil if there are no works" do
      Work.all.each do |work|
        work.destroy
      end

      featured_work = Work.spotlight

      expect(featured_work).must_be_nil
    end
  end

  describe 'top_movies' do
    it 'returns up to 10 records from the movie category' do
      top_10_movies = Work.top_movies

      expect(top_10_movies.count).must_be :<=, 10
      top_10_movies.each do |movie|
        expect(movie.category).must_equal "movie"
      end
    end

    it "returns nil if there are no movies" do
      Work.where(category: "movie").each do |movie|
        movie.destroy
      end

      top_10_movies = Work.top_movies

      expect(top_10_movies).must_be_nil
    end
  end

  describe 'top_albums' do
    it 'returns up to 10 records from the album category' do
      top_10_albums = Work.top_albums

      expect(top_10_albums.count).must_be :<=, 10
      top_10_albums.each do |album|
        expect(album.category).must_equal "album"
      end
    end

    it "returns nil if there are no albums" do
      Work.where(category: 'album').each do |album|
        album.destroy
      end

      top_10_albums = Work.top_albums

      expect(top_10_albums).must_be_nil
    end
  end

  describe 'top_books' do
    it 'returns up to 10 records from the book category' do
      top_10_books = Work.top_books

      expect(top_10_books.count).must_be :<=, 10
      top_10_books.each do |book|
        expect(book.category).must_equal "book"
      end
    end

    it "returns nil if there are no books" do
      Work.where(category: "book").each do |book|
        book.destroy
      end

      top_10_books = Work.top_books

      expect(top_10_books).must_be_nil
    end
  end

  describe 'all_movies' do
    it 'returns a collection of records with category = movie' do
      movies = Work.all_movies

      movies.each do |movie|
        expect(movie.category).must_equal "movie"
      end
    end

    it "returns nil if there are no movies" do
      Work.where(category: 'movie').each do |work|
        work.destroy
      end

      movies = Work.all_movies

      expect(movies).must_be_nil
    end
  end

  describe 'all_books' do
    it 'returns a collection of records with category = books' do
      books = Work.all_books

      books.each do |book|
        expect(book.category).must_equal "book"
      end
    end

    it "returns nil if there are no books" do
      Work.where(category: "book").each do |book|
        book.destroy
      end

      books = Work.all_books

      expect(books).must_be_nil
    end
  end

  describe 'all_albums' do
    it 'returns a collection of records with category = album' do
      albums = Work.all_albums

      albums.each do |album|
        expect(album.category).must_equal "album"
      end
    end

    it "returns nil if there are no albums" do
      Work.where(category: "album").each do |album|
        album.destroy
      end

      albums = Work.all_albums

      expect(albums).must_be_nil
    end
  end
end
