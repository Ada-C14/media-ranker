require "test_helper"

describe Work do
  let (:work) {
    Work.new(category: "movie", title: "title", creator: "creator.", publication_year: 2020, description: "description")
  }

  let (:user){
    User.create(username: "Anna")
  }

  let (:vote_1){
    Vote.create(vote_id: vote_1.id, user_id: user.id, work_id: work.id)
  }

  let (:vote_2){
    Vote.create(vote_id: vote_2.id, user_id: user.id, work_id: work.id)
  }

  it "can be instantiated" do
    #Assert
    expect(work.valid?).must_equal true
  end

  it "it will have the required fields" do
    # Arrange
    work.save
    work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|

    # Assert
    expect(work).must_respond_to field
    end
  end

  # describe "relationships" do
  #   it "can have many votes" do
  #     # Arrange
  #     work.save!
  #     vote_1
  #     vote_2
  #
  #     # Assert
  #     expect(work.votes.count).must_equal 2
  #     work.votes.each do |vote|
  #       expect(vote).must_be_instance_of Work
  #     end
  #   end
  # end

  describe "validations" do
    it "must have and a title" do
      # Arrange
      work.title = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have and a publication year and it have to be a integer" do
      # Arrange
      work.publication_year = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :publication_year
      expect(work.errors.messages[:publication_year]).must_equal ["can't be blank", "is not a number"]
    end

    it "must have a publication year greater than 1900" do
      # Arrange
      work.publication_year = 1899

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :publication_year
      expect(work.errors.messages[:publication_year]).must_equal ["must be greater than 1900"]
    end

    it "must have and a publication year less than current year" do
      # Arrange
      work.publication_year = 2024

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :publication_year
      expect(work.errors.messages[:publication_year]).must_equal ["must be less than 2021"]
    end
  end

  describe "Custom methods" do

    it "can get the top 10 items by category" do
      40.times do
        Work.create(
          category: ["album", "book", "movie"].sample,
          title: "title",
          creator: "creator",
          publication_year: 2020,
          description: "description"
        )
      end

      top_ten = Work.top_ten("album")
      expect(top_ten.size).must_equal 10
    end
  end
    #
    # it "Work.media_spotlight : can be show the top voted item" do
    #   work
    #   expect(Work.media_spotlight).must_equal work
    # end
end
