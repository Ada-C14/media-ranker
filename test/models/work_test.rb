require "test_helper"

describe Work do
  describe "validations" do
    before do
      @spacejam = works(:spacejam)
      @practicalmagic = works(:practicalmagic)
      @lathe = works(:lathe)
    end

  it "requires title field must not be blank" do

    # when creating new entries
    blank_title = Work.new(title: nil, category: "album", creator: "some white guy", publication_year: "2020", description: "some stuff" )
    expect(blank_title.valid?).must_equal false
    expect(blank_title.errors.messages).must_include :title
    expect(blank_title.errors.messages[:title]).must_equal ["can't be blank"]

    # when renaming existing entries
    expect(@spacejam.update(title: nil)).must_equal false
  end

  it "requires title field be unique among its category" do

    # when creating new entries
    dup_movie_title = Work.new(title: "Space Jam", category: "movie", creator: "some white guy", publication_year: "1996", description: "some stuff" )
    expect(dup_movie_title.valid?).must_equal false
    expect(dup_movie_title.errors.messages).must_include :title
    expect(dup_movie_title.errors.messages[:title]).must_equal ["has already been taken"]

    # when renaming existing entries
    expect(@practicalmagic.update(title: "Lathe of Heaven")).must_equal false
  end

  it "allows a duplicate title if it's for a separate category" do

    # when creating new entries
    dup_book_title = Work.new(title: "Space Jam", category: "book", creator: "some white guy", publication_year: "1996", description: "some stuff" )
    expect(dup_book_title.valid?).must_equal true

    # when renaming existing entries
    expect(@spacejam.update(title: "Practical Magic")).must_equal true
  end

  it "rejects invalid categories" do

    invalid_categories = ['banana', 28982, nil]
    invalid_categories.each do |category|
      work = Work.new(title: "test", category: category)
      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :category
    end
  end

  end

  describe "custom methods" do
    before do
      @spacejam = works(:spacejam)
      @practicalmagic = works(:practicalmagic)
      @lathe = works(:lathe)
      @user = users(:testuser)
    end

    it "self.by_category gathers works of a specific category" do

      # correctly pulls books when handed book category
      expect(Work.by_category("book")).must_include @practicalmagic && @lathe

      # correctly does not pull movies when handed book category
      expect(Work.by_category("book")).wont_include @spacejam

      # displays a message if no works exist
      Work.destroy_all
      expect(Work.by_category("book")).must_be_kind_of String
    end

    it "self.media_spotlight pulls the top voted work" do

      # positive nominal
      Vote.create!(user_id: @user.id, work_id: @lathe.id)
      expect(Work.media_spotlight).must_be_instance_of Work
      expect(Work.media_spotlight.votes_count).must_equal Work.maximum(:votes_count)

      # pulls first if ties
      Vote.create!(user_id: @user.id, work_id: @practicalmagic.id)
      expect(Work.media_spotlight).must_be_instance_of Work
      expect(Work.media_spotlight.votes_count).must_equal Work.maximum(:votes_count)
      expect(Work.media_spotlight).must_equal @lathe

      # displays a message if no works exist
      Work.destroy_all
      expect(Work.media_spotlight).must_be_kind_of String
    end

    it "self.top_ten pulls up to ten works" do

    # pulls top ten if ten+ available TODO: Why wouldn't it let me name stuff4 in .yml 'd' ??? Had to be 'de'??
    all_movies = Work.all.find_all { |work| work.category == "movie" }
    expect(Work.top_ten("movie").count).must_equal all_movies.length

    # if less than ten works available, displays max possible
    all_books = Work.all.find_all { |work| work.category == "book" }
    expect(Work.top_ten("book").count).must_equal all_books.length

    # displays a message if no works exist
    Work.destroy_all
    expect(Work.top_ten("book")).must_be_kind_of String
    end
  end
end
