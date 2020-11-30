require "test_helper"

describe Work do

  before do
  @work = Work.new(
      category: "movie",
      title: "An Adie is Sleepy",
      creator: "Ada Wizards",
      publication_year: "2020",
      description: "I would like to go to sleep now."
    )
  end


  describe "validations" do

    it "creates a new media record" do
      @work.save
      expect(@work.valid?).must_equal true
    end

    it "must have a category" do
      @work.category = nil
      expect(@work.valid?).must_equal false
    end

    it "must have a title" do
      @work.title = nil
      expect(@work.valid?).must_equal false
    end

    it "must have a creator" do
      @work.creator = nil
      expect(@work.valid?).must_equal false
    end

    it "must have a publication year" do
      @work.publication_year = nil
      expect(@work.valid?).must_equal false
    end

    it "must have a description" do
      @work.description = nil
      expect(@work.valid?).must_equal false
    end

  end

  # describe "custom methods" do
  #   it "returns a spotlight work" do
  #     expect(Work.spotlight).must_be_instance_of Work
  #   end
  #
  #   it "returns nil for spotlight when database is empty" do
  #     Work.delete_all
  #
  #     expect(Work.count).must_equal 0
  #     expect(Work.spotlight).must_be_nil
  #   end
  #
  #   it "returns an array for top 10" do
  #     top_books = Work.top_ten("book")
  #     expect(top_books).must_be_instance_of Array
  #   end
  #
  # end
end