require "test_helper"

describe Work do
  describe 'validations' do
    before do
      @work = Work.new(category: 'book', title: 'Test Title', creator: 'Test Creator', publication_year: 1999, description: 'Test description blah blah blah')
    end

    it 'is valid when fields are filled' do
      result = @work.valid?

      expect(result).must_equal true
    end

    it 'fails validation when there is no title' do
      @work.title = nil

      result = @work.valid?
      error1 = @work.errors.messages.include?(:title)
      error2 = @work.errors.messages[:title].include?("can't be blank")

      expect(result).must_equal false
      expect(error1).must_equal true
      expect(error2).must_equal true
    end

    it 'fails validation if title is not unique' do

      Work.create!(category: 'book', title: @work.title, creator: 'Test Creators', publication_year: 1998, description: 'Test description blah blah')

      result = @work.valid?
      error3 = @work.errors.messages.include?(:title)
      error4 = @work.errors.messages[:title].include?("has already been taken")

      expect(result).must_equal false
      expect(error3).must_equal true
      expect(error4).must_equal true
    end

    it 'fails if publication year is not an integer' do
      @work.publication_year = "Dog"

      result = @work.valid?

      expect(result).must_equal false
    end
  end

  describe 'relationships' do
    describe 'Work' do
      before do
        @work = Work.create!(category: 'book', title: 'Test Title', creator: 'Test Creator', publication_year: 1999, description: 'Test description blah blah blah')
      end
      it 'can set the work using a Work' do
        # work = Work.create!(category: 'movie', title: 'Test Work', creator: 'Test Created', publication_year: 2000, description: 'Test D blah blah blah')
        work = @work
        vote = Vote.new(work_id: work.id)

        vote.work = work

        expect(vote.work_id).must_equal work.id
      end

      it 'can set the work using an work_id' do
        work = @work
        vote = Vote.new(work_id: work.id)

        vote.work_id = work.id

        expect(vote.work).must_equal work
      end
    end

    xdescribe 'Vote' do

    end
  end

  describe 'Custom Methods' do

  end
end
