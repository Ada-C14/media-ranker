require "test_helper"

describe Work do

  let (:new_work) {
    Work.new(category: "Album", title: "Currents", creator: "Tame Impala", publication_year: 2015, description: "Cool songs and stuff")
  }

  it "can be instantiated" do
    # Assert
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_work.save
    work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|

      # Assert
      expect(work).must_respond_to field
    end
  end

  describe "relationships" do

  end

  describe "validations" do
    it "Won't allow a new work to be created without all required fields" do
      new_work.title = nil

      expect(new_work.valid?).must_equal false
      #expect(new_work.errors.messages).must_include :title
      #expect(new_work.errors.messages[:title]).must_equal
    end
  end

  describe "category_filter" do
    it "will return just the works from a particular category" do
      Work.create(category: "Book", title: "Bluebeard", creator: "Kurt Vonnegut", publication_year: 1979, description: "haven't finished this one yet")
      Work.create(category: "Book", title: "test book", creator: "me", publication_year: 2020, description: "uninteresting")
      Work.create(category: "Album", title: "Currents", creator: "Tame Impala", publication_year: 2015, description: "Cool songs and stuff")

      filtered_works = Work.all.category_filter("Book")

      assert_equal("Book", filtered_works.last[:category])

      assert_equal(2, filtered_works.count)
    end
  end

  describe "spotlight" do
    it "will give 10 works with the highest votes" do

    end
  end
end

