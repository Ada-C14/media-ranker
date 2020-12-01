require "test_helper"

describe User do
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
