require 'test_helper'

describe Work do
  # step 1 setup your model for the test, knowing if it will pass or fail.
  # create two books, same name

  # step 2 test with expected results.
  # expect one to be valid, other to fail.

  describe 'validations' do
    # Can we have these validations present/ or test before writing any code for the user
    let (:work) {
      Work.new(
        title: 'The very hungary caterpillar',
        description: 'Childrens book',
        creator: 'Eric Carle',
        publication_year: 1969,
        category: 'book'
      )
    }

    let (:work2) {
      Work.new(
        title: 'Joe Treat',
        description: 'Childrens book',
        creator: 'Eric Carle',
        publication_year: 1969,
        category: 'book'
      )
    }

    it "must be valid" do
      value(work).must_be :valid?
    end

    it 'is invalid without a title' do
      work.title = nil
      result = work.valid?
      expect(result).must_equal false
    end

    it 'is invalid without a numeric year' do
      work.publication_year = "Ninteen Forty"
      result = work.valid?
      expect(result).must_equal false
    end

    it 'is invalid with multiple books of the same title' do
      expect(work2.valid?).must_equal false
    end

    it 'is invalid if category is not one of book, album, or movie' do
      work.category = "article"
      result = work.valid?
      expect(result).must_equal false
    end
  end

  describe 'custom method' do

    it 'albums should all be valid albums' do
      Work.albums

      work.albums.each do |album|
        value(album).must_be :valid?
        value(album).must_equal 'album'
      end
    end

    it 'books should all be valid books' do
      Work.books

      work.books.each do |book|
        value(book).must_be :valid?
        value(book).must_equal 'book'
      end
    end

    it 'movies should all be valid movies' do
      Work.movies

      work.movies.each do |movie|
        value(movie).must_be :valid?
        value(movie).must_equal 'movie'
      end
    end

    it 'spotlight should return only 1 valid work' do
      Work.spotlight

      value(spotlight).must_be :valid?
    end

    it 'top_10 should return random 10 works' do
      Work.spotlight

      value(spotlight).must_be :valid?
    end

  end

  # describe 'relations' do
  #   it 'can set the author through "author"' do
  #     # Create two models
  #     author = Author.create!(name: "test author")
  #     book = Book.new(title: "test book")
  #
  #     # Make the models relate to one another
  #     book.author = author
  #
  #     # author_id should have changed accordingly
  #     expect(book.author_id).must_equal author.id
  #   end
  #
  #   it 'can set the author through "author_id"' do
  #     # Create two models
  #     author = Author.create!(name: "test author")
  #     book = Book.new(title: "test book")
  #
  #     # Make the models relate to one another
  #     book.author_id = author.id
  #
  #     # author should have changed accordingly
  #     expect(book.author).must_equal author
  #   end
  # end
end
