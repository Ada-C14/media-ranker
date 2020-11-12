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

  # TODO: Add fixtures
  describe "relationships" do
    before do
      new_work.save
      @user_1 = User.create({username: "test user 1"})
      @user_2 = User.create({username: "test user 2"})

      Vote.create(user_id: @user_1.id, work_id: new_work.id)
      Vote.create(user_id: @user_2.id, work_id: new_work.id)
    end

    it "can have many votes" do
      expect(new_work.votes.count).must_equal 2

      new_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it "can have many users through votes" do
      expect(new_work.users.count).must_equal 2

      expect(new_work.users.first).must_equal @user_1
      expect(new_work.users.last).must_equal @user_2

      new_work.users.each do |user|
        expect(user).must_be_instance_of User
      end
    end
  end

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

    it "must have a category" do
      # Arrange
      new_work.category = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      expect(new_work.errors.messages[:category]).must_equal ["can't be blank"]
    end
  end

  # For top-10 or spotlight, what if there are less than 10 works? What if there are no works?
  describe "custom methods" do
    describe "spotlight" do
      it "returns only one work" do
        # Arrange
        new_work.save
        Work.create(category: "movie", title: "test movie title", creator: "test creator", publication_year: 2020, description: "test description")

        # Act
        spotlight_work = Work.spotlight

        # Assert
        expect(Work.count).must_equal 2
        expect(spotlight_work).must_be_instance_of Work
        # expect(spotlight_work.count).must_equal 1 TODO find a way to test this better
      end

      it "returns the most voted for work" do
        # Arrange
        new_work.save
        second_work = Work.create!(category: "movie", title: "test movie title", creator: "test creator", publication_year: 2020, description: "test description")

        user = User.create!(username: "test user")
        Vote.create!(user_id: user.id, work_id: new_work.id)

        # Act
        spotlight_work = Work.spotlight

        # Assert
        expect(second_work.votes.count).must_equal 0
        expect(spotlight_work.votes.count).must_equal 1
        expect(spotlight_work).must_be_instance_of Work
        expect(spotlight_work).must_equal new_work
      end

      it "returns the first work if there are two works with the same amount of votes" do
        # Arrange
        new_work.save
        second_work = Work.create!(category: "movie", title: "test movie title", creator: "test creator", publication_year: 2020, description: "test description")

        user = User.create!(username: "test user")
        Vote.create!(user_id: user.id, work_id: new_work.id)
        Vote.create!(user_id: user.id, work_id: second_work.id)

        # Act
        spotlight_work = Work.spotlight

        # expect(spotlight_work.count).must_equal 1
        expect(spotlight_work).must_equal new_work
        expect(spotlight_work.votes.count).must_equal 1
        expect(second_work.votes.count).must_equal 1
        expect(spotlight_work).must_be_instance_of Work
      end

      it "returns the first work if there are no votes for any works" do
        # Arrange
        new_work.save
        second_work = Work.create!(category: "movie", title: "test movie title", creator: "test creator", publication_year: 2020, description: "test description")

        # Act
        spotlight_work = Work.spotlight

        # Assert
        expect(spotlight_work).must_equal new_work
        expect(spotlight_work.votes.count).must_equal 0
        expect(second_work.votes.count).must_equal 0
        expect(spotlight_work).must_be_instance_of Work
      end
    end

    it "if there are no works at all then the spotlight work must be nil" do
      spotlight_work = Work.spotlight
      expect(spotlight_work).must_be_nil
    end
  end

  # TODO How do top-10 and spotlight handle works with no votes? Ties in the number of votes?
  describe "top ten" do
    it "can return only the top ten works if there are at least ten works (for now just random)" do
      # Arrange
      11.times do |i|
        Work.create!(category: "book", title: "test title #{i + 1}", creator: "test creator #{i + 1}", publication_year: 2019, description: "test description #{i + 1}")
      end

      # Act
      top_ten = Work.top_ten("book")

      # Assert
      expect(top_ten.count).must_equal 10
    end

    it "should return only the top ten works from the same category" do
      # Arrange
      10.times do |i|
        Work.create!(category: "book", title: "test title #{i + 1}", creator: "test creator #{i + 1}", publication_year: 2019, description: "test description #{i + 1}")
      end

      Work.create!(category: "movie", title: "test title 11", creator: "test creator 11", publication_year: 2019, description: "test description 11")
      Work.create!(category: "album", title: "test title 12", creator: "test creator 12", publication_year: 2019, description: "test description 12")

      new_user = User.create!(username: "test user")

      # Act
      top_ten = Work.top_ten("book")

      # Assert
      top_ten.each do |work|
        Vote.create(work_id: work.id, user_id: new_user.id)
      end

      top_ten.each do |work|
        expect(work.category).must_equal "book"
        expect(work.votes.count).must_equal 1
      end
      expect(top_ten.count).must_equal 10
    end

    it "returns all works available if there are not at least 10" do
      # Arrange
      5.times do |i|
        Work.create!(category: "book", title: "test title #{i + 1}", creator: "test creator #{i + 1}", publication_year: 2019, description: "test description #{i + 1}")
      end

      # Act
      top_ten = Work.top_ten("book")

      # Assert
      expect(top_ten.count).must_equal 5
    end

    it "if there are no works then the top ten array must be empty" do
      top_ten = Work.top_ten("book")
      expect(top_ten).must_be_empty
    end
  end
end

