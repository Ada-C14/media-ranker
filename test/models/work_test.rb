require "test_helper"

describe Work do

  describe "validations" do
    it "is valid when all fields are present" do
      work = Work.new(category: "book", title: "Big Friendship", publication_year: "2020", description: "A book about friendship")
      result = work.valid?
      expect(result).must_equal true
    end

    it "must have a category" do
      result = works(:hp1)
      result[:category] = nil
      expect(result.valid?).must_equal false
    end

    it "must have a title" do
      result = works(:hp1)
      result[:title] = nil
      expect(result.valid?).must_equal false
    end

    it "must have a unique title" do
      book = works(:hp1)
      book_copy = Work.new(category: "book", title: book.title)
      expect(book_copy.valid?).must_equal false
    end
  end

  describe "custom methods" do

    before do

      Vote.all.each do |vote|
        vote.delete
      end
      # The counter cache doesn't get updated for fixtures, have to manually create votes
      Vote.create!(work_id: works(:hp1).id, user_id: users(:harry).id)
      Vote.create!(work_id: works(:hp2).id, user_id: users(:john).id)
      Vote.create!(work_id: works(:hp1).id, user_id: users(:justin).id)
      Vote.create!(work_id: works(:hp2).id, user_id: users(:harry).id)
      Vote.create!(work_id: works(:hp2).id, user_id: users(:mark).id)
      Vote.create!(work_id: works(:mulan).id, user_id: users(:julia).id)
      Vote.create!(work_id: works(:mulan).id, user_id: users(:nikki).id)
      Vote.create!(work_id: works(:up).id, user_id: users(:quinn).id)
      Vote.create!(work_id: works(:hp2).id, user_id: users(:julia).id)
      Vote.create!(work_id: works(:hp3).id, user_id: users(:julia).id)
      Vote.create!(work_id: works(:hp4).id, user_id: users(:julia).id)
      Vote.create!(work_id: works(:hp5).id, user_id: users(:julia).id)
      Vote.create!(work_id: works(:hp6).id, user_id: users(:julia).id)
      Vote.create!(work_id: works(:hp7).id, user_id: users(:julia).id)
      Vote.create!(work_id: works(:sandman).id, user_id: users(:julia).id)
      Vote.create!(work_id: works(:murderbot1).id, user_id: users(:julia).id)
      Vote.create!(work_id: works(:DFZ1).id, user_id: users(:julia).id)
      Vote.create!(work_id: works(:DFZ2).id, user_id: users(:julia).id)
      Vote.create!(work_id: works(:moana).id, user_id: users(:julia).id)
      Vote.create!(work_id: works(:dragon).id, user_id: users(:julia).id)

      # @dragon = works(:dragon)
      # @moana = works(:moana)
      # @sandman = works(:sandman)
      # @hp2 = works(:hp2)
      # @hp1 = works(:hp1)
      # @mulan = works(:mulan)
      # @up = works(:up)
      # @dfz1 = works(:DFZ1)
      # @dfz1 = works(:DFZ2)
      # @hp3 = works(:hp3)
      # @hp4 = works(:hp4)
      # @hp5 = works(:hp5)
      # @hp6 = works(:hp6)
      # @hp7 = works(:hp7)
      # @murderbot1 = works(:murderbot1)
      # @dragon.reload
      # @moana.reload
      # @sandman.reload
      # @hp2.reload
      # @hp1.reload
      # @mulan.reload
      # @up.reload
      # @dfz1.reload
      # @dfz1.reload
      # @hp3.reload
      # @hp4.reload
      # @hp5.reload
      # @hp6.reload
      # @hp7.reload
      # @murderbot1.reload
    end
    describe "spotlight" do
      it "returns the most voted and the most recently recreated work" do
        expect(Work.spotlight).must_be_instance_of Work
        expect(Work.spotlight).must_equal works(:hp2)
      end

      it "returns nil if there are no works" do
        Work.all.each { |work| work.delete }
        expect(Work.spotlight).must_be_nil
      end

      it "if there's one work but no votes, features the work" do
        Work.all.each { |work| work.delete }
        Work.create!(category: "album", title: "test title")
        expect(Work.spotlight.title).must_equal "test title"
      end
    end

    describe "top ten" do
      it "returns a list of 10 work objects for books sorted by number of votes then date created" do
        top_ten_books = Work.top_ten("book")
        expect(top_ten_books.length).must_equal 10
        expect(top_ten_books.first).must_be_instance_of Work
        top_ten_books.each do |book|
          expect(book.category).must_equal "book"
        end
        expect(top_ten_books.first).must_equal works(:hp2)
        expect(top_ten_books.last).must_equal works(:DFZ2)
      end

      it "returns a list of work objects for movies sorted by number of votes then date created" do
        top_ten_movies = Work.top_ten("movie")
        expect(top_ten_movies.length).must_equal 4
        expect(top_ten_movies.first).must_be_instance_of Work
        top_ten_movies.each do |work|
          expect(work.category).must_equal "movie"
        end
        expect(top_ten_movies.first).must_equal works(:mulan)
        expect(top_ten_movies.last).must_equal works(:up)
      end

      it "returns an empty list for albums" do
        album = Work.top_ten("album")
        expect(album.length).must_equal 0
      end
    end

    describe "single_or_plural_votes" do
      it "returns a singular 'vote' if there is 1 vote" do
        work = works(:up)
        work.reload
        expect(work.single_or_plural_votes).must_equal "1 Vote"
      end

      it "returns a plural 'votes' if there are 0 or 2+ votes" do
        work = works(:hp1)
        work.reload
        expect(work.single_or_plural_votes).must_equal "2 Votes"
      end
    end
  end

  describe "relationships" do
    it "can have many users through votes" do
      work = works(:hp1)
      expect(work.users.length).must_equal 2
      expect(work.users.first).must_equal users(:harry)
      expect(work.users.last).must_equal users(:justin)
    end

    it "can have many votes" do
      work = works(:hp1)
      expect(work.votes.count).must_equal 2
    end
  end
end
