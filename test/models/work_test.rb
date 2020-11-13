require "test_helper"

describe Work do
  describe "validations" do
    it "can be instantiated" do
      # test each entry from work.yml file:
      works.each do |work|
        expect(work.valid?).must_equal true
      end
    end

    it "will must have the required fields" do
      # each entry is failing a validation
      invalid_works = [
        test1_book = Work.new(
          category: 'car', # invalid category
          title: 'test book 1',
          creator: 'test author 1',
          publication_year: 2011,
          description: 'test book description 1'
        ),
        test2_book = Work.new(
          category: 'book',
          # missing title
          creator: 'test author 1',
          publication_year: 2011,
          description: 'test book description 1'
        ),
        test3_book = Work.new(
          category: 'book',
          title: 'test book 1',
          # missing creator
          publication_year: 2011,
          description: 'test book description 1'
        ),
        test4_book = Work.new(
          category: 'book',
          title: 'test book 1',
          creator: 'test author 1',
          # missing publication year
          description: 'test book description 1'
        ),
        test5_book = Work.new(
          category: 'book',
          title: 'test book 1',
          creator: 'test author 1',
          publication_year: 2011,
          # missing description
        )
      ]
      invalid_works.each do |invalid_work|
        expect(invalid_work.valid?).must_equal false
      end
    end
  end


  describe "spotlight" do
    it "can return the top rated work" do
      wave_1_spotlight = works(:test3_book)
      expect(wave_1_spotlight).must_be_instance_of Work
      # TODO: future waves, incorporate top votes
    end
  end

  describe "top media" do
    it "can instantiate a random sample (up to 10) of media/works" do
      works.each do |work|
        expect(work).must_be_instance_of Work
      end
      # TODO: future waves, incorporate top votes
    end
  end

end
