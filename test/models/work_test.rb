require "test_helper"

describe Work do
  
  let (:new_work) {
    Work.create(
        category: "book",
        title: "Test Book",
        creator: "Test Author",
        publication_year: 2020,
        description: "Test Description"
    )
  }

  it "can be instantiated" do
    # Assert
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_work.save
    work = Work.first
    [:category, :title].each do |field|

      # Assert
      expect(work).must_respond_to field
    end
  end

  describe "relations" do
    it 'can have many Votes' do
      work = works(:album)

      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
      expect(work.votes.count).must_equal 3
    end
  end

  describe "validations" do
    it 'must have a category' do
      new_work.category = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category

    end

    it 'must have a title' do
      new_work.title = nil
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it 'must have a creator' do
      new_work.creator = nil
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :creator
      expect(new_work.errors.messages[:creator]).must_equal ["can't be blank"]
    end

    it 'must have a description' do
      new_work.description = nil
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :description
      expect(new_work.errors.messages[:description]).must_equal ["can't be blank"]
    end

    it 'must have a publication year' do
      new_work.publication_year = nil
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
    end

    it 'must be an integer the publication year' do
      new_work.publication_year = 2020.05

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
    end

    it 'must have a valid date' do
      new_work.publication_year = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
    end
  end

  describe 'spotlight' do

    it 'returns one work that has the most votes' do
      top_album = works(:album)
      top_votes = top_album.votes.count
      expect(Work.spotlight).must_be_instance_of Work
      expect(Work.spotlight).must_equal top_album
      expect(Work.spotlight.votes.count).must_equal top_votes
    end

    it "returns nil if there are no works" do
      Work.all.delete_all

      expect(Work.spotlight).must_be_nil
    end

  end

  describe 'top_ten' do
    it 'returns up to 10 records from a category' do
      top_movies = Work.top_ten("movie")
      top_books = Work.top_ten("book")
      top_albums = Work.top_ten("album")

      expect(top_movies.length).must_be :<=, 10
      expect(top_books.length).must_be :<=, 10
      expect(top_albums.length).must_be :<=, 10
      top_movies.each do |movie|
        expect(movie.category).must_equal "movie"
      end
      top_books.each do |book|
        expect(book.category).must_equal "book"
      end
      top_albums.each do |album|
        expect(album.category).must_equal "album"
      end
    end

    it "returns empty array if there are no works" do
      Work.all.each do |work|
        work.destroy
      end

      top_movies = Work.top_ten("movie")
      top_books = Work.top_ten("book")
      top_album = Work.top_ten("album")

      expect(top_movies.length).must_equal 0
      expect(top_books.length).must_equal 0
      expect(top_album.length).must_equal 0
    end
  end


end
