require "test_helper"

describe Work do

  it 'can be instantiated' do
    (Work.new).must_be_instance_of Work
  end

  it "will have the required fields" do
    work = works(:test_book)
    [:category, :title, :creator, :publication_year, :description].each do |check|
      expect(work).must_respond_to check
    end
  end

  describe "relationships" do
    it "can have many users through votes" do
      work = works(:test_book)
      expect(work.users.length).must_equal 2
      expect(work.users.first).must_equal users(:first)
      expect(work.users.last).must_equal users(:third)
    end

    it "can have many votes" do
      work = works(:test_book)
      expect(work.votes.count).must_equal 2
    end
  end

  describe "validations" do

    it 'must have a title' do
      work = works(:test_book)
      work[:title] = nil

      expect(work.valid?).must_equal false
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]

    end

    it 'must have a category' do
      work = works(:test_book)
      work.category = nil

      expect(work.valid?).must_equal false
      expect(work.errors.messages[:category]).must_equal ["can't be blank", " is not a valid category"]
    end

    it 'must have a creator' do
      work = works(:test_book)
      work.creator = nil

      expect(work.valid?).must_equal false
      expect(work.errors.messages[:creator]).must_equal ["can't be blank"]
    end

    it 'must have a publication year' do
      work = works(:test_book)
      work.publication_year = nil

      expect(work.valid?).must_equal false
      expect(work.errors.messages[:publication_year]).must_equal ["can't be blank", "is not a number"]
    end

  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
