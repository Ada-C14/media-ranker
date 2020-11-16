require "test_helper"

describe Work do
  before do
    @work1 = works(:rare)
    @work2 = works(:folklore)
    @work3 = works(:titanic)
    @work4 = works(:ace)
    @work5 = works(:onward)
    @work6 = works(:becoming)
    @work7 = works(:it)
  end

  it "can be instantiated" do
    [@work1, @work2, @work3, @work4, @work5, @work6, @work7].each do |user|
      expect(user.valid?).must_equal true
    end
  end

  it "will have the required fields" do
    [@work1, @work2, @work3, @work4, @work5, @work6, @work7].each do |user|
      expect(user).must_respond_to :id
      expect(user).must_respond_to :category
      expect(user).must_respond_to :title
      expect(user).must_respond_to :description
      expect(user).must_respond_to :publication_year
      expect(user).must_respond_to :created_at
      expect(user).must_respond_to :updated_at
    end
  end

  describe "validations" do
    it "work is valid if title exists" do
      new_work = Work.create(
          title: "The Alchemist",
          category: "book",
          publication_year: 1988,
          creator: "Paolo Coelho"
      )

      expect(new_work.valid?).must_equal true
    end

    it "work is invalid if title is nil" do
      @work1.title = nil

      expect(@work1.valid?).must_equal false
      expect(@work1.errors.messages).must_include :title
      expect(@work1.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    it "can have many votes" do
      assert_operator @work1.votes.count, :>, 1

      @work1.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "custom methods" do
    it "can get the spotlight Work" do
      expect(Work.get_spotlight).must_equal works(:rare)
      expect(Work.get_spotlight).must_be_instance_of Work
      expect(Work.get_spotlight.title).must_equal works(:rare).title
      expect(Work.get_spotlight.creator).must_equal works(:rare).creator
      expect(Work.get_spotlight.publication_year).must_equal works(:rare).publication_year
    end

    it "There is no spotlight if there are no works" do
      Work.destroy_all

      expect(Work.get_spotlight).must_be_nil
    end

    it "can get the top 10 (or less) of a category, and sort by number of votes, then alphabetically" do
      top_movies = Work.get_top_ten("movie")

      top_movies.each do |work|
        expect(work).must_be_instance_of Work
        expect(work[:category]).must_equal "movie"
      end

      expect(top_movies.first.title).must_equal works(:ace).title
      expect(top_movies.last.title).must_equal works(:us).title
    end

    it "if category has more than 10 works, method only returns the first 10" do
      album_1 = works(:rare)
      album_2 = works(:folklore)
      album_3 = works(:album3)
      album_4 = works(:album4)
      album_5 = works(:album5)
      album_6 = works(:album6)
      album_7 = works(:album7)
      album_8 = works(:album8)
      album_9 = works(:album9)
      album_10 = works(:album10)
      album_11 = works(:album11)
      book_1 = works(:becoming)
      top_albums = Work.get_top_ten("album")

      expect(top_albums.length).must_equal 10
    end

    it "if category has no works, get_top_ten returns nil" do
      Work.destroy_all

      expect(Work.all.length).must_equal 0
    end
  end
end
