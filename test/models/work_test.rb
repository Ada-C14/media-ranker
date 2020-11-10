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
end
