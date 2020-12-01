require "test_helper"

# All validations and should be tested
# - All custom methods should be tested
# - For top-10 or spotlight, what if there are less than 10 works? What if there are no works?
# Write at least one test for each relation on a model
# Write at least one test for each validation on a model
# Write at least one test for each custom method on a model
# Each model also needs one test where all the validations pass
#   category: movie
#   title: FirstWork
#   creator: FirstWork Creator
#   description: a description of the first work
#   publication_year: 2021


describe Work do
  let (:new_work) {
    Work.new(
        title: "Some Title",
        category: "album",
        creator: "Mos",
        description: "asd sdlkjf sdi sdkjr sdois s oadij slkk dkjle so di elksj eiolksdlk sskl sdlke soio",
        publication_year: 2222)
  }
  it "can be instantiated" do
    # Assert
    expect(new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_work.save
    work = Work.first
    [:title, :category, :creator, :description, :publication_year].each do |field|

      # Assert
      expect(work).must_respond_to field
    end
  end

  describe 'relations' do
    it "has many votes" do
      skip
      #   book = books(:poodr)
      #   expect(book.author).must_equal authors(:metz)
    end

    it "has many users through votes" do
      skip
      # book = Book.new(title: "test book")
      # book.author = authors(:metz)
      # expect(book.author_id).must_equal authors(:metz).id
    end
  end

  describe 'validation' do
     it "must have a title" do
       work = works(:first_work)
       expect(work.title).must_equal works(:first_work).title
    end

    it "title must be unique" do
      skip
      # book = Book.new(title: "test book")
      # book.author = authors(:metz)
      # expect(book.author_id).must_equal authors(:metz).id
    end
  end

  describe "custom methods" do
    it "top_ten" do
      skip
      # book = Book.new(title: "test book")
      # book.author = authors(:metz)
      # expect(book.author_id).must_equal authors(:metz).id
    end

    it "spotlight" do
      skip
      # book = Book.new(title: "test book")
      # book.author = authors(:metz)
      # expect(book.author_id).must_equal authors(:metz).id
    end
  end
end

describe User do
  it "can be instantiated" do
    new_user = User.create(name: "Third User")

    expect(new_user.valid?).must_equal true
  end

  it "will have the required fields" do
    users = User.all

    users.each do |user|
      expect(user).must_respond_to :name
      expect(user).must_be_instance_of User
    end
  end

  describe 'relations' do
    it "can have many votes" do
      user = users(:user1)

      # Assert
      expect(user.votes.count).must_equal 2
      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it "has many works through votes" do
      user = users(:user1)

      user.votes.each do |vote|
        expect(vote.work).must_be_instance_of Work
      end
    end
  end

  describe 'validation' do
    it "must have a name" do
      user = User.first

      expect(user.valid?).must_equal true
      expect(user.name).must_equal users(:user1).name
    end

    it "must raise errors for invalid name" do
      user = users(:user1)
      user.name = nil

      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :name
      expect(user.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "name must be unique" do
      new_user = User.create(name: "Second User")

      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :name
      expect(new_user.errors.messages[:name]).must_equal ["has already been taken"]
    end
  end
end
