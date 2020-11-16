require "test_helper"

describe Work do
  describe 'validations' do
    before do
      # Arrange
      @work = works(:movie)
    end

    it 'is valid when all fields are present' do
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is not valid when fields are not present' do
      @work = Work.new()

      result = @work.valid?

      expect(result).must_equal false
    end
  end
  describe 'spotlight' do
    it 'spotlight work is instance of work' do
      @work = works(:movie)

      @works = Work.all

      result = @works.spotlight

      expect(result).must_be_instance_of Work
    end
    it 'chooses the most voted for piece of work' do
      @work = works(:book)

      @works = Work.all

      result = @works.spotlight

      expect(result.title).must_be_same_as "Normal People"
    end
  end
  describe 'top_ten' do
    it 'creates an array of movies' do
      @works = Work.all
      result = @works.top_ten_movies

      expect(result).must_be_instance_of Array
    end

    it 'creates an array of books' do
    @works = Work.all
    result = @works.top_ten_books

    expect(result).must_be_instance_of Array
    end

    it 'creates an array of albums' do
    @works = Work.all
    result = @works.top_ten_albums

    expect(result).must_be_instance_of Array
    end
  end
  describe 'sort_votes' do
    it 'sorts works by votes' do
      @work = works(:book)
      @works = Work.all

      result = @works.sort_votes

      expect(result.first.title).must_be_same_as @work.title
    end
  end
end
