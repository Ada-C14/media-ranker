require "test_helper"

describe Work do
  let (:new_work) {
    Work.new(category: "book",
             title: "The Book",
             creator: "The Author",
             publication_year: 2020,
             description: "The Description")
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
    it "can have many votes" do
      # Arrange
      new_work.save
      new_user = User.create(username: "User")
      new_user2 = User.create(username: "User2")
      vote_1 = Vote.create(user_id: new_user.id, work_id: new_work.id)
      vote_2 = Vote.create(user_id: new_user2.id, work_id: new_work.id)

      # Assert
      expect(new_work.votes.count).must_equal 2
      expect(vote_1.user).must_equal new_user
      expect(vote_2.user).must_equal new_user2
      new_work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
        expect(vote.work_id).must_equal new_work.id
      end
    end
    it "can get information of users that voted for the work" do
      new_work.save
      new_user = User.create(username: "User")
      new_user2 = User.create(username: "User2")
      vote_1 = Vote.create(user_id: new_user.id, work_id: new_work.id)
      vote_2 = Vote.create(user_id: new_user2.id, work_id: new_work.id)

      # Assert
      expect(new_work.users.count).must_equal 2
      # check info
      expect(new_work.users.find_by(username: "User")).must_equal new_user
      expect(new_work.users.find_by(username: "User2")).must_equal new_user2
      new_work.users.each do |user|
        expect(user).must_be_instance_of User
      end
    end

  end

  describe "validations" do
    it "must have a title" do
      # Arrange
      new_work.title = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :title
      expect(new_work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a unique title per category type" do
      # save two works: one with same title and category, one with diff category
      new_work.save
      repeat_work = Work.new(category: "book", title: "The Book")
      new_cat_work = Work.new(category: "movie", title: "The Book")

      # Assert
      # repeat
      expect(repeat_work.valid?).must_equal false
      expect(repeat_work.errors.messages).must_include :title
      expect(repeat_work.errors.messages[:title]).must_equal ["has already been taken"]
      # new work
      expect(new_cat_work.valid?).must_equal true
      expect(new_cat_work.errors.messages).must_be_empty
    end

    it "must have a category" do
      # Arrange
      new_work.category = nil

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      # note: even though they get the same message,
      # nil vs a wrong category still have to be tested separately
      expect(new_work.errors.messages[:category]).must_equal ["must be book, movie, or album"]
    end

    it "accepts valid categories regardless of case, converting to downcase" do
      caps_work = Work.new(category: "MOVIE", title: "Movie")

      # Assert
      expect(caps_work.valid?).must_equal true
      expect(caps_work.errors.messages).must_be_empty
      expect(caps_work.category).must_equal 'movie'
    end

    it "rejects invalid category types as a safeguard" do
      # Arrange
      new_work.category = 'FAKER'

      # Assert
      expect(new_work.valid?).must_equal false
      expect(new_work.errors.messages).must_include :category
      # note: even though they get the same message,
      # nil vs a wrong category still have to be tested separately
      expect(new_work.errors.messages[:category]).must_equal ["must be book, movie, or album"]
    end

    # we know the behavior of integer typecasting
    # but we also want to document the behavior from a user POV
    it "converts float years to integers, strings to integer" do
      # try a float
      new_work.publication_year = 2.44
      expect(new_work.publication_year).must_equal 2

      # try a string
      new_work.publication_year = 'NOTAYEAR'
      expect(new_work.publication_year).must_equal 0

      # try a numerical string
      new_work.publication_year = '1999'
      expect(new_work.publication_year).must_equal 1999
    end
  end

  describe "custom methods" do
    before do
      @user = User.create(username: 'voter')
      @work1 = Work.new(category: 'book', title: 'A')
      @work2 = Work.new(category: 'book', title: 'B')
      @work3 = Work.new(category: 'movie', title: 'A')
      @work4 = Work.new(category: 'album', title: 'A')
    end

    describe "spotlight" do
      it "returns nil if there are no works" do
        assert_nil(Work.spotlight)
      end
      it "returns work with most votes" do
        @work1.save
        @work2.save

        Vote.create(work_id: @work2.id, user_id: @user.id)

        expect(Work.spotlight).must_equal @work2
        expect(Work.spotlight.votes.count).must_equal 1
        expect(Work.spotlight.votes.count).must_equal @work2.votes.count
      end
      it "returns work earlier in alphabet if top have same number of votes" do
        @work1.save
        @work2.save


        expect(Work.spotlight).must_equal @work1
        expect(Work.spotlight.votes.count).must_equal 0
        expect(Work.spotlight.votes.count).must_equal @work2.votes.count
      end

      it "returns work created earlier if same title (possible with diff. cat) and same number of votes" do
        @work1.save
        sleep(1)
        @work3.save


        expect(Work.spotlight).must_equal @work3
        expect(Work.spotlight.votes.count).must_equal 0
        expect(Work.spotlight.votes.count).must_equal @work1.votes.count
        expect(Work.spotlight.title).must_equal @work1.title
      end
    end

    describe "sort_cat" do
      it 'returns empty array for when there are no works for a certain category' do
        expect(Work.sort_cat('book')).must_be_empty
        expect(Work.sort_cat('book')).must_be_kind_of Array
      end
      it 'returns an array of works in a category sorted by vote, most to least ' do
        # two book entries
        @work1.save
        @work2.save

        # vote for one
        Vote.create(work_id: @work2.id, user_id: @user.id)

        # get sorted array
        sorted_books = Work.sort_cat('book')

        expect(sorted_books.length).must_equal 2
        expect(sorted_books.first).must_equal @work2
        expect(sorted_books.first.id).must_equal @work2.id
        expect(sorted_books.first.votes.count).must_equal 1
        expect(sorted_books.last.votes.count).must_equal 0
      end

      it "sorts works with the same number of votes in ABC order" do
        # two book entries
        @work1.save
        @work2.save

        # get sorted array
        sorted_books = Work.sort_cat('book')

        expect(sorted_books.length).must_equal 2
        expect(sorted_books.first).must_equal @work1
        expect(sorted_books.first.id).must_equal @work1.id
        expect(sorted_books.first.votes.count).must_equal 0
        expect(sorted_books.last.votes.count).must_equal 0
      end
    end

    # sort_cat is already tested, will just check for # num of elements and instance types
    describe "work_hash" do
      it "returns an hash with empty arrays of values if there are no works" do
        empty_arrays = Work.work_hash
        expect(empty_arrays.length).must_equal 3
        empty_arrays.each {|cat, array| expect(array).must_be_empty}
      end
      it "returns a hash with keys matching to what category the array contains works of" do
        @work1.save
        @work2.save
        @work3.save
        @work4.save

        work_hash = Work.work_hash
        expect(work_hash.length).must_equal 3

        total_works = 0
        work_hash.each do |cat, array|
          expect(array.length).must_equal Work.where(category: cat.to_s.chop).count
          total_works += array.length
          array.each {|work| expect(work.category).must_equal cat.to_s.chop}
        end

        expect(total_works).must_equal Work.all.count
      end
    end
  end
end

