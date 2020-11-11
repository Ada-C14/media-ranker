require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  let (:new_work) {
    Work.create(category: "Book", title: "Test book", creator: "Bruce Lee", publication_date: "2020", description: "This is very helpful book for testing")
  }
  it "can be instantiated" do
    #assert
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_work.save
    work = Work.first
    [:category, :title, :creator, :publication_date, :description].each do |field|
      # Assert
      expect(work).must_respond_to field
    end
  end

  describe "validations" do
    #arrange
    before do
      @work = Work.create(category: "Movie", title: "It", creator: "Someone Withimagination", publication_date: "2018", description: "This is very scary movie")
    end
    it "is invalid without a title" do
      # act
      @work.title = nil

      # Assert
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
      expect(@work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it 'is valid when all fields are present' do
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid with a non-unique title' do
      # Arrange

      # we create a new work unique_work,
      # and modify @work so it becomes invalid
      # to follow the pattern of invalidating @work
      unique_work = Work.create!(category: "Movie", title: "Unique movie", creator: "Talent", publication_date: "2018", description: "This is very unique movie")
      @work.title = unique_work.title

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end
  end

  # describe "custom methods" do
  #   describe "top_by_category" do
  #     before do
  #       @work = Work.create(category: "Movie", title: "It", creator: "Someone Withimagination", publication_date: "2018", description: "This is very scary movie")
  #     end
  #     it "returns a message if category is nil" do
  #       #arrange
  #       @work.category = nil
  #       #act+assert
  #       expect(@work.top_by_category("Movie")).must_equal "There is no item of this category"
  #     end
  #   end
  # end

  describe "relations" do
  end
end
