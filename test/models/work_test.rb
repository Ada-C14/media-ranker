require "test_helper"

describe Work do

  it 'can be instantiated' do
    (Work.new).must_be_kind_of Work
  end

  it "will have the required fields" do
    work = works(:test_book)
    [:category, :title, :creator, :publication_year, :description].each do |check|
      expect(work).must_respond_to check
    end
  end

  describe "relationships" do
    # Your tests go here
  end

  describe "validations" do
    let work = works(:test_book)
    it 'must have a title' do
      work.title = nil

      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :vin
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]

    end

    it 'must have a category' do

    end

    it 'must have a creator' do

    end

    it 'must have a publication year' do

    end

    it 'must have a description' do

    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
