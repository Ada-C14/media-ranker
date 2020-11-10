require "test_helper"

describe Work do

  let (:new_work) {
    Work.new(category: "book", title: "Title 1", creator: "Creator 1", publication_year: "2021", description: "Description 1")
  }

  it "can be instantiated" do
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    new_work.save
    work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|
      expect(work).must_respond_to field
    end
  end

  describe "validations" do
    it "must have a category" do
      new_work.category = nil
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "must have a title" do
      new_work.title = nil
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a creator" do
      new_work.creator = nil
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :creator
      expect(new_work.errors.messages[:creator]).must_equal ["can't be blank"]
    end

    it "must have a publication year" do
      new_work.publication_year = nil
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
      expect(new_work.errors.messages[:publication_year]).must_equal ["can't be blank"]
    end

    it "must have a description" do
      new_work.description = nil
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :description
      expect(new_work.errors.messages[:description]).must_equal ["can't be blank"]
    end

  end
end


  
