require "test_helper"

describe Work do
  before do
    @new_work = Work.new(category: "work", title: "Test Work", creator: "Someone", publication_year: 2020, description: "NA")
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

  describe "relationships" do
    it "can have many votes and many users through votes" do
      @new_work.save
      user1 = users(:user1)
      user2 = users(:user2)
      first_vote = Vote.create(work_id: @new_work.id, user_id: user1.id)
      second_vote = Vote.create(work_id: @new_work.id, user_id: user2.id)

      expect(@new_work.votes.count).must_equal 2
      @new_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
        expect(vote.work_id).must_equal @new_work.id
      end

      expect(@new_work.votes.first.user_id).must_equal user1.id
      expect(@new_work.votes.last.user_id).must_equal user2.id

      expect(@new_work.users.count).must_equal 2
      @new_work.users.each do |user|
        expect(user).must_be_instance_of User
      end

      expect(@new_work.users.first).must_equal user1
      expect(@new_work.users.last).must_equal user2
    end
  end

  describe "validations" do
    it "must have a category" do
      @new_work.category = nil

      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :category
      expect(@new_work.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "must have a title" do
      @new_work.title = nil

      expect(@new_work.valid?).must_equal false
      expect(@new_work.errors.messages).must_include :title
      expect(@new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end

  describe "custom methods" do
    describe "sort_by_votes" do
      it "can sort all works by most number of votes to least" do
        sorted_media = Work.sort_by_votes

        expect(sorted_media.length).must_equal 14
        expect(sorted_media.first).must_equal works(:book)
        expect(sorted_media.first.votes.count).must_equal 3

        expect(sorted_media.last.votes.count).must_equal 0
      end

      it "returns an empty array if there are no works" do
        Work.delete_all
        sorted_media = Work.sort_by_votes

        expect(sorted_media).must_be_empty
      end
    end

    describe "top_10" do
      it "returns top ten works in a category with more than ten works" do
        top_10_movies = Work.top_10("movie")

        expect(top_10_movies.length).must_equal 10
        expect(top_10_movies.first).must_equal works(:movie11)
        expect(top_10_movies.first.votes.count).must_equal 2

        top_10_movies.each do |movie|
          expect(movie.category).must_equal "movie"
          expect(movie.votes.count).must_equal 1 if movie != top_10_movies.first
        end

        expect(top_10_movies).wont_include works(:movie)
      end

      it "returns an empty array if there are no works in a category" do
        Work.delete_by(category: "movie")
        top_10_movies = Work.top_10("movie")

        expect(top_10_movies).must_be_empty
      end

      it "returns the top works in a category with less than ten works" do
        top_10_albums = Work.top_10("album")
        
        expect(top_10_albums.length).must_equal 2
        expect(top_10_albums.first).must_equal works(:album)
        expect(top_10_albums.last).must_equal works(:album2)

        top_10_albums.each do |album|
          expect(album.category).must_equal "album"
        end
      end
    end

    describe "spotlight" do
      it "returns the media with the most number of votes" do
        expect(Work.spotlight).must_equal works(:book)
      end

      it "returns nil if there are no works" do
        Work.delete_all

        expect(Work.spotlight).must_be_nil
      end
    end
  end
end
