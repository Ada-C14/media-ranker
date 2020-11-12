require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(category: "book",
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
    [:category, :title].each do |field|

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
      new_user2 = User.create(username: "User2")
      vote_1 = Vote.create(user_id: new_user.id, work_id: new_work.id)
      vote_2 = Vote.create(user_id: new_user2.id, work_id: new_work.id)

      # Assert
      expect(new_work.users.count).must_equal 2
      new_work.users.each do |user|
        expect(user).must_be_instance_of User
      end
    end

  end

  describe "validations" do
    it "must have a title" do
      # Arrange
      new_work.title = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a unique title per category type" do
      # save two works: one with same title and category, one with diff category
      new_work.save
      repeat_work = Work.new(category: "book", title: "The Book")
      new_cat_work = Work.new(category: "movie", title: "The Book")

      # Assert
      # repeat
      expect(repeat_work.valid?).must_equal false
      expect(repeat_work.errors.messages).must_include :title
      expect(repeat_work.errors.messages[:title]).must_equal ["has already been taken"]
      # new work
      expect(new_cat_work.valid?).must_equal true
      expect(new_cat_work.errors.messages).must_be_empty
    end

    it "must have a category" do
      # Arrange
      new_work.category = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      # note: even though they get the same message,
      # nil vs a wrong category still have to be tested separately
      expect(new_work.errors.messages[:category]).must_equal ["must be book, movie, or album"]
    end

    it "accepts valid categories regardless of case, converting to downcase" do
      caps_work = Work.new(category: "MOVIE", title: "Movie")

      # Assert
      expect(caps_work.valid?).must_equal true
      expect(caps_work.errors.messages).must_be_empty
      expect(caps_work.category).must_equal 'movie'
    end

    it "rejects invalid category types as a safeguard" do
      # Arrange
      new_work.category = 'FAKER'

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      # note: even though they get the same message,
      # nil vs a wrong category still have to be tested separately
      expect(new_work.errors.messages[:category]).must_equal ["must be book, movie, or album"]
    end

    # we know the behavior of integer typecasting
    # but we also want to document the behavior from a user POV
    it "converts float years to integers, strings to integer" do
      # try a float
      new_work.publication_year = 2.44
      expect(new_work.publication_year).must_equal 2

      # try a string
      new_work.publication_year = 'NOTAYEAR'
      expect(new_work.publication_year).must_equal 0

      # try a numerical string
      new_work.publication_year = '1999'
      expect(new_work.publication_year).must_equal 1999
    end
  end
end

