require "test_helper"

describe Work do
  let(:new_work) {
    Work.new(category: "book", title: "test title", creator: "test creator", publication_year: 2020, description: "test description")
  }

  it "can be instantiated" do
    # Assert
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_work.save
    work = Work.first

    # Assert
    [:category, :title, :creator, :publication_year, :description].each do |field|
      expect(work).must_respond_to field
    end
  end

  # TODO: Add tests for relationships
  # describe "relationships" do
  # end

  describe "validations" do
    it "has a title" do
    # Arrange
    new_work.title = nil

    # Assert
    expect(new_work.valid?).must_equal false
    expect(new_work.errors.messages).must_include :title
    expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "cannot add a work if another work from the same category has the same title" do
      # Arrange
      new_work.save
      same_title_work = Work.create(category: "book", title: "test title", creator: "test creator", publication_year: 2019, description: "test description")

      # Assert
      expect(same_title_work.valid?).must_equal false
      expect(same_title_work.errors.messages).must_include :title
      expect(same_title_work.errors.messages[:title]).must_equal ["has already been taken"]
    end

    it "can add a work with the same title if it is not from the same category" do
      # Arrange
      new_work.save
      same_title_work = Work.create!(category: "album", title: "test title", creator: "test creator", publication_year: 2019, description: "test description")

      # Assert
      expect(same_title_work.valid?).must_equal true
    end
  end

  # For top-10 or spotlight, what if there are less than 10 works? What if there are no works?
  describe "custom methods" do
    describe "spotlight" do
      it "returns only one work" do
        new_work.save
        work = Work.spotlight

        expect(work).must_be_instance_of Work
        expect(Work.count).must_equal 1
      end

      it "returns the most voted for work (for now random until votes model is added)" do
      end
    end

    it "if there are no works then the spotlight work must be nil" do
      work = Work.spotlight
      expect(work).must_be_nil
    end
  end

  describe "top ten" do
    it "can return only the top ten works if there are at least ten works (for now just random)" do
      work_1 = Work.create!(category: "book", title: "test title 1", creator: "test creator 1", publication_year: 2019, description: "test description 1")
      work_2 = Work.create!(category: "book", title: "test title 2", creator: "test creator 2", publication_year: 2019, description: "test description 2")
      work_3 = Work.create!(category: "book", title: "test title 3", creator: "test creator 3", publication_year: 2019, description: "test description 3")
      work_4 = Work.create!(category: "book", title: "test title 4", creator: "test creator 4", publication_year: 2019, description: "test description 4")
      work_5 = Work.create!(category: "book", title: "test title 5", creator: "test creator 5", publication_year: 2019, description: "test description 5")
      work_6 = Work.create!(category: "book", title: "test title 6", creator: "test creator 6", publication_year: 2019, description: "test description 6")
      work_7 = Work.create!(category: "book", title: "test title 7", creator: "test creator 7", publication_year: 2019, description: "test description 7")
      work_8 = Work.create!(category: "book", title: "test title 8", creator: "test creator 8", publication_year: 2019, description: "test description 8")
      work_9 = Work.create!(category: "book", title: "test title 9", creator: "test creator 9", publication_year: 2019, description: "test description 9")
      work_10 = Work.create!(category: "book", title: "test title 10", creator: "test creator 10", publication_year: 2019, description: "test description 10")
      work_11 = Work.create!(category: "book", title: "test title 11", creator: "test creator 11", publication_year: 2019, description: "test description 11")

      top_ten = Work.top_ten("book")
      expect(top_ten.count).must_equal 10
    end

    it "should return only the top ten works from the same category" do
      work_1 = Work.create!(category: "book", title: "test title 1", creator: "test creator 1", publication_year: 2019, description: "test description 1")
      work_2 = Work.create!(category: "book", title: "test title 2", creator: "test creator 2", publication_year: 2019, description: "test description 2")
      work_3 = Work.create!(category: "book", title: "test title 3", creator: "test creator 3", publication_year: 2019, description: "test description 3")
      work_4 = Work.create!(category: "book", title: "test title 4", creator: "test creator 4", publication_year: 2019, description: "test description 4")
      work_5 = Work.create!(category: "book", title: "test title 5", creator: "test creator 5", publication_year: 2019, description: "test description 5")
      work_6 = Work.create!(category: "book", title: "test title 6", creator: "test creator 6", publication_year: 2019, description: "test description 6")
      work_7 = Work.create!(category: "book", title: "test title 7", creator: "test creator 7", publication_year: 2019, description: "test description 7")
      work_8 = Work.create!(category: "book", title: "test title 8", creator: "test creator 8", publication_year: 2019, description: "test description 8")
      work_9 = Work.create!(category: "book", title: "test title 9", creator: "test creator 9", publication_year: 2019, description: "test description 9")
      work_10 = Work.create!(category: "book", title: "test title 10", creator: "test creator 10", publication_year: 2019, description: "test description 10")
      work_11 = Work.create!(category: "movie", title: "test title 11", creator: "test creator 11", publication_year: 2019, description: "test description 11")
      work_12 = Work.create!(category: "album", title: "test title 12", creator: "test creator 12", publication_year: 2019, description: "test description 12")

      top_ten = Work.top_ten("book")
      top_ten.each do |work|
        expect(work.category).must_equal "book"
      end
    end

    it "returns all works available if there are not at least 10" do
    work_1 = Work.create!(category: "book", title: "test title 1", creator: "test creator 1", publication_year: 2019, description: "test description 1")
    work_2 = Work.create!(category: "book", title: "test title 2", creator: "test creator 2", publication_year: 2019, description: "test description 2")
    work_3 = Work.create!(category: "book", title: "test title 3", creator: "test creator 3", publication_year: 2019, description: "test description 3")
    work_4 = Work.create!(category: "book", title: "test title 4", creator: "test creator 4", publication_year: 2019, description: "test description 4")
    work_5 = Work.create!(category: "book", title: "test title 5", creator: "test creator 5", publication_year: 2019, description: "test description 5")

    top_ten = Work.top_ten("book")
    expect(top_ten.count).must_equal 5
    end

    it "if there are no works then the top ten array must be empty" do
      top_ten = Work.top_ten("book")
      expect(top_ten).must_be_empty
    end
  end
end

