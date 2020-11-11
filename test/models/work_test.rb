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

    it 'is value when all fields are present' do
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

end
