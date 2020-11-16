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
    it "can have many votes" do
      work = Work.create(category: "Book", title: "Bluebeard", creator: "Kurt Vonnegut", publication_year: 1979, description: "haven't finished this one yet")
      user = User.create(username: "test")
      user2 = User.create(username: "test2")
      Vote.create(work_id: work[:id],user_id: user[:id])
      Vote.create(work_id: work[:id],user_id: user2[:id])

      expect(work.votes.count).must_equal 2
    end
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
    it "gives the work with the highest votes" do
      @work = Work.create(category: "book", title: "test book", creator: "test", publication_year: 2011, description: "test")

      @user = User.create(username: "test")

      Vote.create(work_id: @work[:id],user_id: @user[:id])
      expect(Work.all.spotlight.title).must_equal @work.title
    end
  end

  describe "top10" do
    it "will give a list of works with the highest votes" do
      @work = Work.create(category: "book", title: "test book", creator: "test", publication_year: 2011, description: "test")
      @work2 = Work.create(category: "book", title: "test book2", creator: "test2", publication_year: 2011, description: "test")
      @user = User.create(username: "test")

      Vote.create(work_id: @work[:id],user_id: @user[:id])
      Vote.create(work_id: @work2[:id],user_id: @user[:id])

      expect(Work.all.top10("book")).must_equal [@work2, @work]
    end
  end
end

