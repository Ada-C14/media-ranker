require "test_helper"

describe Work do
  describe "validations" do
    before do
      @work = Work.new(category: "book", title: "Death on the Nile", creator: "Agatha Christie", publication_year: 1937, description: "Hercule Poirot is not allowed to take a vacation")
    end

    it "creates a work when given valid data" do
      success = @work.valid?

      expect(success).must_equal true
    end

    it "won't create a work without a title" do
      @work.title = nil

      success = @work.valid?

      expect(success).must_equal false
    end

    it "won't create a work with a duplicate title" do
      @work.save
      @second_work = Work.new(category: "album", title: "Death on the Nile")

      success = @second_work.valid?

      expect(success).must_equal false
    end

    it "only accepts integers for publication years" do
      @work.publication_year = "The Thirties"

      success = @work.valid?

      expect(success).must_equal false
    end

    it "will not create a work with an invalid category" do
      @work.category = "TV Show"

      success = @work.valid?

      expect(success).must_equal false
    end
  end

  describe "relationships" do
    before do
      @user = User.first
      @work = Work.first
      @vote = Vote.new(user: @user, work: @work)
    end

    it "can have a vote" do
      @vote.save

      expect(@work.votes.count).must_equal 1
      expect(@work.votes.first).must_equal @vote
    end

    it "can have a user through a vote" do
      @vote.save

      expect(@work.users).must_include @user
    end
  end

  describe "spotlight" do
    it "returns one work" do
      spotlight = Work.spotlight

      expect(spotlight).must_be_instance_of Work
    end
  end

  describe "top_ten" do
    it "returns a hash with one pair per category" do
      tops = Work.top_ten
      categories = [:albums, :books, :movies]

      expect(tops.count).must_equal 3
      expect(tops.keys).must_equal categories
    end

    it "returns up to ten of each category of work" do
      tops = Work.top_ten
      album = tops[:albums]
      book = tops[:books]
      movie = tops[:movies]

      expect(album.count).must_be :<=,10
      expect(book.count).must_be :<=,10
      expect(movie.count).must_be :<=,10
    end
  end
end
