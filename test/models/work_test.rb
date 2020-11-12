require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  describe 'validations' do
    before do
      @work = Work.new(
          category: "book",
          title: "test work",
          creator: "test creator",
          publication_year: 2003,
          description: "blah blah"
      )
    end

    it 'is valid when all fields are present' do
      result = @work.valid?

      expect(result).must_equal true
    end

    it 'is invalid without a title' do
      @work.title = nil

      result = @work.valid?

      expect(result).must_equal false
    end

    it 'is invalid if the title and category exists' do

      existing_work = Work.create(
          category: "book",
          title: "test work",
          creator: "lalala",
          publication_year: 2010,
          description: "blah blah"
      )

      result = @work.valid?

      expect(result).must_equal false

    end

    it 'is valid even if the title exist but with a different category' do

      existing_work = Work.create(
          category: "movie",
          title: "test work",
          creator: "lalala",
          publication_year: 2010,
          description: "blah blah"
      )

      result = @work.valid?

      expect(result).must_equal true

    end
  end

  describe 'top_10' do
    it 'should extract 10 works of the category' do

      category = "book"

      books = Work.top_10(category)

      expect(books.count).must_equal 10
    end

    it "should extract works even if there are less than 10" do
      category = "movie"

      movies = Work.top_10(category)

      expect(movies.count).must_equal 1
    end

    it 'list 0 works if the category does not have any works' do
      category = "album"

      albums = Work.top_10(category)

      expect(albums.count).must_equal 0
    end
  end

  describe "spotlight" do
    it "should be nil if there are no works" do
      Work.delete_all

      spotlight = Work.spotlight

      expect(spotlight).must_be_nil
    end
  end
end
