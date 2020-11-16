require "test_helper"

describe Work do

  let (:new_work_1) {
    Work.create(category: "album", title: "Samba", creator: "Alice B.", publication_year: 2020, description: "Brazilian Samba")
  }

  let (:new_work_2) {
    Work.create(category: "album", title: "Jazz", creator: "Alice B.", publication_year: 2019, description: "Best Jazz")
  }

  let (:new_user_1) {
    User.create(username: "Alice")
  }

  let (:new_user_2) {
    User.create(username: "Denise")
  }

  let (:vote_1) {
    Vote.create(user_id: new_user_1.id, work_id: new_work_1.id)
  }

  let (:vote_2) {
    Vote.create(user_id: new_user_2.id, work_id: new_work_1.id)
  }

  it "can be instantiated" do
    #Assert
    expect(new_work_1.valid?).must_equal true
  end

  it "it will have the required fields" do
    # Arrange
    new_work_1.save
    work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|

    # Assert
    expect(work).must_respond_to field
    end
  end

  describe "relationships" do
    it "can have many votes" do
      # Arrange
      new_work_1.save
      vote_1
      vote_2

      # Assert
      expect(new_work_1.votes.count).must_equal 2
    end
  end

  describe "validations" do
    it "must have and a title" do
      # Arrange
      new_work_1.title = nil

      # Assert
      expect(new_work_1.valid?).must_equal false
      expect(new_work_1.errors.messages).must_include :title
      expect(new_work_1.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a category" do
      # Arrange
      new_work_1.category = nil

      # Assert
      expect(new_work_1.valid?).must_equal false
      expect(new_work_1.errors.messages).must_include :category
    end

    it "must have and a publication year and it have to be a integer" do
      # Arrange
      new_work_1.publication_year = nil

      # Assert
      expect(new_work_1.valid?).must_equal false
      expect(new_work_1.errors.messages).must_include :publication_year
      expect(new_work_1.errors.messages[:publication_year]).must_equal ["can't be blank", "is not a number"]
    end

    it "must have a publication year greater than 1900" do
      # Arrange
      new_work_1.publication_year = 1799

      # Assert
      expect(new_work_1.valid?).must_equal false
      expect(new_work_1.errors.messages).must_include :publication_year
      expect(new_work_1.errors.messages[:publication_year]).must_equal ["must be greater than 1800"]
    end

    it "must have and a publication year less than current year" do
      # Arrange
      new_work_1.publication_year = 2024

      # Assert
      expect(new_work_1.valid?).must_equal false
      expect(new_work_1.errors.messages).must_include :publication_year
      expect(new_work_1.errors.messages[:publication_year]).must_equal ["must be less than 2021"]
    end
  end

  describe "Custom methods" do
    #
    # it "can get the top 10 items by category" do
    #
    #   top_ten_albums = Work.top_ten("album")
    #   expect(top_ten_albums.length).must_equal 10
    #   expect(top_ten_albums).must_be_instance_of Work
    #   # top_ten_albums.each do |album|
    #   #   expect(album.category).must_equal "album"
    #   end
    #   # expect(top_ten_albums.first).must_equal new_work_1
    #   # expect(top_ten_albums.last).must_equal new_work_2
    # end

      it "returns the most voted work" do
        new_work_1.save

        expect(Work.media_spotlight).must_be_instance_of Work
        expect(Work.media_spotlight).must_equal new_work_1
      end

    it "returns nil if there are no works" do
      Work.all.each { |work| work.delete }
      expect(Work.media_spotlight).must_be_nil
    end

    it "total votes: returns 0 if no votes" do
      new_work_1
      expect(new_work_1.votes.count).must_equal 0
    end

    it "total of votes: returns total of valid votes" do
      new_work_1
      vote_1
      vote_2

      expect(new_work_1.votes.count).must_equal 2
      end
  end
end
