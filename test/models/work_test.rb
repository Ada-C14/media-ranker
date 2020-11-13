require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end

  # describe "relationships" do
  #   it "can have many trips" do
  #     # Arrange
  #     new_driver.save
  #     new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
  #     trip_1 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
  #     trip_2 = Trip.create(driver_id: new_driver.id, passenger_id: new_passenger.id, date: Date.today, rating: 3, cost: 6334)
  #
  #     # Assert
  #     expect(new_driver.trips.count).must_equal 2
  #     new_driver.trips.each do |trip|
  #       expect(trip).must_be_instance_of Trip
  #     end
  #   end
  # end

  describe "validations" do
    it "must have a title" do
      # Arrange
      work = Work.first
      work.title = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end
    it "must have a description" do
      # Arrange
      work = Work.first
      work.description = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :description
      expect(work.errors.messages[:description]).must_equal ["can't be blank"]
    end
    it "must have a publication date" do
      # Arrange
      work = Work.first
      work.publication_date = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :publication_date
      expect(work.errors.messages[:publication_date]).must_equal ["can't be blank", "is not a number"]

    end
    it "must have a creator" do
      # Arrange
      work = Work.first
      work.creator = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :creator
      expect(work.errors.messages[:creator]).must_equal ["can't be blank"]
    end
    it "must have a category" do
      # Arrange
      work = Work.first
      work.category = nil

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["can't be blank", "category must be a movie, book or album"]

    end
    it "publication date must be a number" do
      # Arrange
      work = Work.first
      work.publication_date = 'December 1975'

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :publication_date
      expect(work.errors.messages[:publication_date]).must_equal ["is not a number"]
    end
    it "category must be a movie, book or album" do
      # Arrange
      work = Work.first
      work.category = 'podcast'

      # Assert
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["category must be a movie, book or album"]

    end
  end

end
