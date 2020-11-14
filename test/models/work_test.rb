require "test_helper"

describe Work do

  let (:new_work) {
    Work.create(
        category: "book",
        title: "Test Book",
        creator: "Test Author",
        publication_year: 2020,
        description: "Test Description"
    )
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

  end

  describe "validations" do
    it 'must have a category' do
      new_work.category = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category

    end

    it 'must have a title' do
      new_work.title = nil
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it 'must have a creator' do
      new_work.creator = nil
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :creator
      expect(new_work.errors.messages[:creator]).must_equal ["can't be blank"]
    end

    it 'must have a description' do
      new_work.description = nil
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :description
      expect(new_work.errors.messages[:description]).must_equal ["can't be blank"]
    end

    it 'must have a publication year' do
      new_work.publication_year = nil
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
    end

    it 'must be an integer the publication year' do
      new_work.publication_year = 2020.05

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
    end

    it 'must have a valid date' do
      new_work.publication_year = nil

      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :publication_year
    end
  end

  describe 'custom methods' do

    it 'must spotlight method select the top voted item' do
      @work

      expect(Work.spotlight).must_equal @work
    end

    it "returns nil if there are no works" do
      Work.all.delete_all

      expect(Work.spotlight).must_be_nil
    end

    it' must top_ten(category) method get the top ten item in each category' do

      50.times do
        Work.create(
            category: ["album", "book", "movie"].sample,
            title: "Test Title",
            creator: "Test Creator",
            publication_year: 2020,
            description: "Test Description"
        )
      end

      top_ten = Work.top_ten("book")
      expect(top_ten.size).must_equal 10
    end


  end


end
