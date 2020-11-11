require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(category: "Book",
             title: "The Book",
             creator: "The Author",
             publication_year: 2020,
             description: "The Description")
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
      # Arrange
      new_work.save
      new_user = User.create(username: "User")
      vote_1 = Vote.create(user_id: new_user.id, work_id: new_work.id)
      vote_2 = Vote.create(user_id: new_user.id, work_id: new_work.id)

      # Assert
      expect(new_work.votes.count).must_equal 2
      new_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
    it "can get information of users that voted for the work" do
      new_work.save
      new_user = User.create(username: "User")
      new_user2= User.create(username: "User2")
      vote_1 = Vote.create(user_id: new_user.id, work_id: new_work.id)
      vote_2 = Vote.create(user_id: new_user2.id, work_id: new_work.id)

      # Assert
      expect(new_work.users.count).must_equal 2
      new_work.users.each do |user|
        expect(user).must_be_instance_of User
      end
    end
  end

=begin
  describe "validations" do
    it "must have a name" do
      # Arrange
      new_passenger.name = nil

      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :name
      expect(new_passenger.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "must have a phone number" do
      # Arrange
      new_passenger.phone_num = nil

      # Assert
      expect(new_passenger.valid?).must_equal false
      expect(new_passenger.errors.messages).must_include :phone_num
      expect(new_passenger.errors.messages[:phone_num]).must_equal ["can't be blank"]
    end
  end
=end
end

