require "test_helper"

describe Work do
  before do
    # Arrange
    @work = works(:dead_alive)
  end

  it 'is valid when all fields are present' do
    # Act
    result = @work.valid?

    # Assert
    expect(result).must_equal true
  end
  #have 9 works, see if it works with, 9, add one (no votes) , see if it is last
  describe 'relationships' do
    it 'can be added to a vote' do
      expect{
        Vote.create(work: @work, user: users(:me))
      }.must_change "@work.votes.count", 1
    end

    it 'has access to users when added to vote' do
      expect{
        Vote.create(work: @work, user: users(:me))
      }.must_change "@work.users.count", 1
    end
  end

  describe 'validations' do

    it "will be valid with string title string creator, string description, string category, and int date_published" do
      expect(@work.valid?).must_equal true
    end

    it "will be invalid without title" do
      @work.title = nil

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
      expect(@work.errors.messages[:title][0]).must_equal "can't be blank"
    end

    it 'will be invalid with non-string title' do
      @work.title = 0

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title
      expect(@work.errors.messages[:title][0]).must_equal "must be a string"
    end

    it "will be invalid without category" do
      @work.title = nil

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category
      expect(@work.errors.messages[:category][0]).must_equal "can't be blank"
    end

    it 'will be invalid with non-string category' do
      @work.title = 0

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category
      expect(@work.errors.messages[:category][0]).must_equal "must be a string"
    end


    it "will be valid with blank creator" do
      @work.creator = nil
      expect(@work.valid?).must_equal true
    end

    it 'will be invalid with non-string creator' do
      @work.creator = 0

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :creator
      expect(@work.errors.messages[:creator][0]).must_equal "must be a string"
    end

    it "will be valid with blank description" do
      @work.description = nil
      expect(@work.valid?).must_equal true
    end

    it 'will be invalid with non-string description' do
      @work.description = 0

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :description
      expect(@work.errors.messages[:description][0]).must_equal "must be a string"
    end

    it "will be valid with blank publication_date" do
      @work.publication_date = nil
      expect(@work.valid?).must_equal true
    end

    it 'will be invalid with non-int publication_date' do
      @work.publication_date = "date"

      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication_date
      expect(@work.errors.messages[:publication_date][0]).must_equal "must be an integer"
    end

  end

  describe 'custom methods' do

  end
end
