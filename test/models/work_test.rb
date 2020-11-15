require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  let (:new_work) {
    Work.create(category: "book", title: "Test book", creator: "Bruce Lee", publication_date: "2020", description: "This is very helpful book for testing")
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
      @work = Work.create(category: "movie", title: "It", creator: "Someone Withimagination", publication_date: "2018", description: "This is very scary movie")
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
      unique_work = Work.create!(category: "movie", title: "Unique movie", creator: "Talent", publication_date: "2018", description: "This is very unique movie")
      @work.title = unique_work.title

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it 'is invalid with invalid category' do
      # arrange
      @work.category = "art"
      # act
      result = @work.valid?
      # assert
      expect(result).must_equal false
    end
  end

  describe "custom methods" do
    describe "top_by_category" do
      it "returns 2 works when asked for 10" do
        #arrange
        work_1 = Work.create(category: "album", title: "Yellow submarine", creator: "Beetles", publication_date: "1967", description: "Legendary album")
        work_2 = Work.create(category: "album", title: "Master of Puppets", creator: "Metallica", publication_date: "1998", description: "Best album ever")
        #act+assert
        expect(Work.top_by_category("album")).must_equal [work_1, work_2]
      end

      it "return empty array when there is no work of particular type" do
        #act+assert
        expect(Work.top_by_category("album")).must_be_empty
      end
    end

    describe "spotlight" do
      it "returns nil when work is empty" do
        #arrange
        #act+assert
        expect(Work.spotlight).must_equal nil
      end

      it "return empty array when there is no work of particular type" do
        #arrange
        work = Work.create(category: "album", title: "Master of Puppets", creator: "Metallica", publication_date: "1998", description: "Best album ever")

        #act+assert
        expect(Work.spotlight).must_equal work
        #because it's a class method I call it on the class,
        # and after that use variable work to compare it with the result
      end
    end
  end

  describe "relations" do
    it "has many votes" do
      work = works(:metallica)
      user = users(:incognito)
      user_2 = users(:bruce_lee)
      vote_1 = Vote.create(work_id: work.id, user_id: user.id)
      vote_2 = Vote.create(work_id: work.id, user_id: user_2.id)
      expect(work.votes.length).must_equal 2
    end
  end
end
