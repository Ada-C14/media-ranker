require "test_helper"

describe Work do

  # let (:new_work) {
  #   Work.new(category: "book", title: "Title 1", creator: "Creator 1", publication_year: "2021", description: "Description 1")
  # }
  before do
    @new_work = Work.new(category: "book", title: "Title 1", creator: "Creator 1", publication_year: "2021", description: "Description 1")

  end

  it "can be instantiated" do
    expect(@new_work.valid?).must_equal true
  end

  it "will have the required fields" do
    @new_work.save
    work = Work.first
    [:category, :title, :creator, :publication_year, :description].each do |field|
      expect(work).must_respond_to field
    end
  end

  describe "validations" do
    it "must have a category" do
      @new_work.category = nil
      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :category
      expect(@new_work.errors.messages[:category]).must_equal ["can't be blank", "not a valid category"]
    end

    it "must have a title" do
      @new_work.title = nil
      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :title
      expect(@new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "only accepts book, album, or movie for category" do
      @new_work.category = "dvd"
      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :category
      expect(@new_work.errors.messages[:category]).must_equal ["not a valid category"]
    end

    it "must have a creator" do
      @new_work.creator = nil
      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :creator
      expect(@new_work.errors.messages[:creator]).must_equal ["can't be blank"]
    end

    it "must have a publication year" do
      @new_work.publication_year = nil
      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :publication_year
      expect(@new_work.errors.messages[:publication_year]).must_equal ["can't be blank", "must be valid"]
    end

    it "must have an integer between 1500 and 2100 for publication year" do
      @new_work.publication_year = "2199"
      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :publication_year
      expect(@new_work.errors.messages[:publication_year]).must_equal ["must be valid"]
    end

    it "must have a description" do
      @new_work.description = nil
      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :description
      expect(@new_work.errors.messages[:description]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    before do
      clear_database
      @work_1 = Work.create!(category: "book", title: "Title 1", creator: "Creator 1", publication_year: "2021", description: "Description 1")
    end

    it "must retrieve a vote and a user when there is a vote for a work" do
      user = User.create!(username: "username")
      vote = Vote.create!(user: user, work: @work_1)
      expect(@work_1.votes.count).must_equal 1
      expect(@work_1.users.count).must_equal 1
    end

    it "must retrieve no votes and no user when there is no vote for a work" do
      expect(@work_1.votes.count).must_equal 0
      expect(@work_1.users.count).must_equal 0
    end

  end

  describe "work model methods" do
    before do
      clear_database
      @books = []
      @albums = []
      @movies = []
      @users = []
      11.times do |i|
        @books << Work.create!(category: "book", title: "book_#{i}", creator: "Creator", publication_year: "2020", description: "Description")
        @albums << Work.create!(category: "album", title: "album_#{i}", creator: "Creator", publication_year: "2020", description: "Description")
        @movies << Work.create!(category: "movie", title: "movie_#{i}", creator: "Creator", publication_year: "2020", description: "Description")
        @users << User.create!(username: "Username_#{i}")
          i.times do |j|
            Vote.create!(work: @books[j], user: @users[i])
            Vote.create!(work: @albums[j], user: @users[i])
            Vote.create!(work: @movies[j], user: @users[i])
          end
      end
    end

  describe "category_organized" do
    it "returns empty list if there are no record for a category" do
      clear_database
      result = Work.category_organized(:book)
      expect(result.count).must_equal 0
    end

    it "returns expected results when there is data" do
      clear_database
      @new_work.save!
      result = Work.category_organized(:book)
      expect(result.count).must_equal 1
    end

    it "returns empty list when we pass in a category that does not exist" do
      clear_database
      result = Work.category_organized(:hello)
      expect(result.count).must_equal 0
    end

    it "returns a list of work for the desired category" do
      result = Work.category_organized(:book)
      result.each do |work|
      expect(work.category).must_equal "book"
      end
      result_2 = Work.category_organized(:album)
      result_2.each do |work|
      expect(work.category).must_equal "album"
      end
      result_3 = Work.category_organized(:movie)
      result_3.each do |work|
      expect(work.category).must_equal "movie"
      end
    end

    it "returns a list of work in descending order of number of votes" do

      result = Work.category_organized(:book)
      count = 11
      result.each do |work|
        expect(work.votes.count <= count).must_equal true
        count = work.votes.count
      end

      result = Work.category_organized(:album)
      count = 11
      result.each do |work|
        expect(work.votes.count <= count).must_equal true
        count = work.votes.count
      end

      result = Work.category_organized(:movie)
      count = 11
      result.each do |work|
        expect(work.votes.count <= count).must_equal true
        count = work.votes.count
      end
    end

  end

  describe "self.top_ten" do
    it "returns 10 work at most" do
      result = Work.top_ten(:book)
      expect(result.size).must_equal 10
    end

    it "returns 0 if no work in the database" do
      clear_database
      result = Work.top_ten(:book)
      expect(result.size).must_equal 0
    end
  end

  describe "self.spotlight" do
    it "returns 1 work at most" do
      result = Work.spotlight
      expect(result).wont_be_nil
    end

    it "returns nil if no work in the database" do
      clear_database
      result = Work.spotlight
      expect(result).must_be_nil
    end
  end

  end
end


