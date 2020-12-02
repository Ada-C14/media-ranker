require "test_helper"

describe Work do
  before do
    # Arrange
    @work = Work.new(category: "book", title: "The Cat in the Hat", creator: "Dr. Seuss", publication_year: 1957, description: "anthropomorphic cat")
    # username = params[:user][:username]
    user = User.create(username: "test_user")
    @login_user = User.all.first
  end

  describe "relations" do
      it "has many votes" do
        parable = works(:parable)
        vote1 = votes(:vote1)
        vote2 = votes(:vote2)

        parable.votes << vote1
        parable.votes << vote2

        # assert_operatorß parable.votes.count, :>, 1

        parable.votes.each do |vote|
          expect(vote).must_be_instance_of Vote
        end
        expect(parable.votes.count).must_equal 2
        end
   end

  describe "validations" do
    it "is valid when all fields are present" do
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it "is invalid without a title" do
      # Arrange
      @work.title = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages.include?(:title)).must_equal true
      expect(@work.errors.messages[:title].include?("can't be blank")).must_equal true
    end

    it "fails validation when title already exists" do
      Work.create(category: "book", title: @work.title, creator: "Dr. Seuss", publication_year: 1957, description: "anthropomorphic cat")

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages.include?(:title)).must_equal true
      expect(@work.errors.messages[:title].include?("has already been taken")).must_equal true
    end

    it "is invalid without a creator" do
      # Arrange
      @work.creator = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :creator
    end

    it "is invalid without a publication year" do
      # Arrange
      @work.publication_year = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :publication_year
    end

    it "is invalid without a description" do
      # Arrange
      @work.description = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :description
    end
  end
end
