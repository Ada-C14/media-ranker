require "test_helper"

describe Work do

  let (:new_work) {
    Work.create(category: "album", title: "Samba", creator: "Alice B.", publication_year: 2020, description: "Brazilian Samba")
  }

  let (:new_user) {
    User.create(username: "Alice")
  }

  let (:vote_1) {
    Vote.create(user_id: new_user.id, work_id: new_work.id)
  }

  let (:vote_2) {
    Vote.create(user_id: new_user.id, work_id: new_work.id)
  }

  it "can be instantiated" do
    #Assert
    expect(new_work.valid?).must_equal true
  end

  it "it will have the required fields" do
    # Arrange
    new_work.save
    work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|

    # Assert
    expect(work).must_respond_to field
    end
  end

  describe "validations" do
    it "must have and a title" do
      # Arrange
      new_work.title = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have and a publication year and it have to be a integer" do
      # Arrange
      new_work.publication_year = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
      expect(new_work.errors.messages[:publication_year]).must_equal ["can't be blank", "is not a number"]
    end

    it "must have a publication year greater than 1900" do
      # Arrange
      new_work.publication_year = 1799

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
      expect(new_work.errors.messages[:publication_year]).must_equal ["must be greater than 1800"]
    end

    it "must have and a publication year less than current year" do
      # Arrange
      new_work.publication_year = 2024

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
      expect(new_work.errors.messages[:publication_year]).must_equal ["must be less than 2021"]
    end
  end

  describe "Custom methods" do

    it "can get the top 10 items by category" do
      30.times do
        Work.create(
          category: ["album", "book", "movie"].sample,
          title: "title",
          creator: "creator",
          publication_year: 2020,
          description: "description"
        )
      end

      top_ten = Work.top_ten("book")
      expect(top_ten.size).must_equal 10
    end

    it "total votes: returns 0 if no votes" do
      new_work
      expect(new_work.votes.count).must_equal 0
    end

    it "total of votes: returns total of valid votes" do
      new_work
      vote_1
      vote_2

      expect(new_work.votes.count).must_equal 2
    end
  end
end
