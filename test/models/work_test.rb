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

    it "tracks number of votes in votes_counter" do
      @work.save
      @user = users(:testuser)
      @vote = Vote.create!(work: @work, user: @user)

      expect(@work.votes_count).must_equal 1
    end
  end

  describe "relationships" do
    before do
      @user = users(:testuser)
      @work = works(:book12)
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
    let (:spotlight) {
      Work.spotlight
    }
    it "returns one work" do
      expect(spotlight).must_be_instance_of Work
    end

    it "returns the work with the most votes in any category" do
      expect(spotlight).must_equal works(:book3)
    end

    it "returns earliest-added work if no works have votes" do
      all_votes = Vote.all
      all_votes.each do |vote|
        vote.destroy
      end

      expect(spotlight).must_equal works(:album5)
    end

    it "returns earliest-added of winners if there's a tie for most votes" do
      work = works(:book2)
      user = users(:testuser)
      tie_vote = Vote.new(work: work, user: user)
      tie_vote.save

      expect(spotlight).must_equal works(:book2)
    end
  end

  describe "top_ten" do
    before do
      @top_albums = Work.top_ten("album")
      @top_books = Work.top_ten("book")
      @top_movies = Work.top_ten("movies")
    end

    it "returns works for a given category" do
      top_book = @top_books.first

      expect(top_book).must_be_instance_of Work
      expect(top_book.category).must_equal "book"
    end

    it "returns up to ten of each category of work" do
      expect(@top_albums.count).must_be :<=,10
      expect(@top_books.count).must_be :<=,10
      expect(@top_movies.count).must_be :<=,10
    end

    it "returns nothing if there are no works in a category" do
      status = @top_movies.empty?

      expect(status).must_equal true
    end

    it "orders works from most to least votes" do
      top_book = @top_books.first
      last_book = @top_books.last

      expect(top_book).must_equal works(:book3)
      expect(last_book.votes_count).must_equal 1
    end

    it "orders works with same votes by creation date" do
      oldest_entry = @top_albums.first.created_at
      newest_entry = @top_albums.last.created_at

      status = oldest_entry < newest_entry
      expect(status).must_equal true
    end
  end
end
