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
    it "is an instance of work" do
      wave_1_spotlight = works(:test3_book)
      expect(wave_1_spotlight).must_be_instance_of Work
    end

    it "can return the top rated work" do
      expected = works(:test1_book).id
      wave_2_spotlight = Work.spotlight
      expect(wave_2_spotlight).must_equal expected

    end
  end

  describe "top media" do
      it "returns an array of work instances" do
        media = %w[book movie album]
        media.each do |category|
          top_media = Work.top_works(category)
          expect(top_media).must_be_instance_of Array
          top_media.each do |medium|
            expect(medium).must_be_instance_of Work
          end
        end
      end

    it "returns correct number of works" do
      count = 3
      media = %w[book movie album]
      media.each do |category|
        top_media = Work.top_works(category, count)
        expect(top_media.length).must_equal count
      end
    end


      it "the first work has the most votes" do
        top_media = works(:test1_book)
        most_votes = top_media.votes.length
        expect(Work.top_works('book').first).must_equal top_media
        expect(Work.top_works('book').first.votes.count).must_equal most_votes
      end


    end
end
