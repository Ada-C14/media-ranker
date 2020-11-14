require "test_helper"

describe Work do
  before do
    @work = Work.new(
        category: "book",
        title: "Book1",
        creator: "Test Author",
        publication_year: 2020,
        description: "A test description"
    )
  end
  describe 'initialize' do
    it 'can be initialized' do
      expect(@work.valid?).must_equal true
    end

    it 'will have the required fields' do
      @work.save
      work = Work.find_by(title: "Book1")
      [:category, :title, :creator, :publication_year, :description].each do |field|
        expect(work).must_respond_to field
      end
    end
  end
  describe 'validations' do
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
    it "returns the work with the most votes" do
      featured_work = Work.spotlight
      most_votes = works(:book)

      expect(featured_work.id).must_equal most_votes.id
    end

    it "returns nil if there are no works" do
      Work.all.each do |work|
        work.destroy
      end

      featured_work = Work.spotlight

      expect(featured_work).must_be_nil
    end
  end

  describe 'top_works' do
    it 'returns up to 10 records from a category' do
      top_movies = Work.top_works("movie")
      top_books = Work.top_works("book")
      top_albums = Work.top_works("album")

      expect(top_movies.count.values.first).must_be :<=, 10
      expect(top_books.count.values.first).must_be :<=, 10
      expect(top_albums.count.values.first).must_be :<=, 10
      top_movies.each do |movie|
        expect(movie.category).must_equal "movie"
      end
      top_albums.each do |album|
        expect(album.category).must_equal "album"
      end
      top_books.each do |book|
        expect(book.category).must_equal "book"
      end
    end

    it "returns nil if there are no works" do
      Work.all.each do |work|
        work.destroy
      end

      top_movies = Work.top_works("movie")
      top_books = Work.top_works("book")
      top_album = Work.top_works("album")

      expect(top_movies).must_be_nil
      expect(top_books).must_be_nil
      expect(top_album).must_be_nil
    end
  end

  describe 'sort_by_vote_count' do
    it 'returns a an ActiveRecord relation object with elements sorted in descending order' do
      sorted_works = Work.sort_by_vote_count
      votes = 3

      expect(sorted_works).must_be_kind_of ActiveRecord::Relation
      sorted_works.each do |work|
        expect(work.votes.count).must_equal votes
        votes -= 1
      end
    end
  end
end
