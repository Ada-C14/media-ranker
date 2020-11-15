require "test_helper"

describe Work do
  it "can be instantiated" do
    # Assert
    expect(works(:book).valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    # works(:book).save
    work = Work.first
    [:category, :title].each do |field|

      # Assert
      expect(work).must_respond_to field
    end
  end

  describe "relationships" do
    before do
      # Arrange
      # @new_user = User.create(username: "User")
      # @new_user2 = User.create(username: "User2")
      # @vote_1 = Vote.create(user_id: @new_user.id, work_id: works(:book).id)
      # @vote_2 = Vote.create(user_id: @new_user2.id, work_id: works(:book).id)
    end
    it "can have many votes" do
      expect(works(:book).votes.count).must_equal 1
      expect(votes(:vote).user).must_equal users(:user)
      works(:book).votes.each do |vote|
        expect(vote).must_be_instance_of Vote
        expect(vote.work_id).must_equal works(:book).id
      end
    end
    it "can get information of users that voted for the work" do
      # Assert
      expect(works(:book).users.count).must_equal 1
      # check info
      expect(works(:book).users.find_by(username: "user")).must_equal users(:user)
      works(:book).users.each do |user|
        expect(user).must_be_instance_of User
      end
    end

  end

  describe "validations" do
    it "must have a title" do
      # Arrange
      works(:book).title = nil

      # Assert
      expect(works(:book).valid?).must_equal false
      expect(works(:book).errors.messages).must_include :title
      expect(works(:book).errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "must have a unique title per category type" do
      # only need to create invalid objects here thanks to fixtures
      repeat_work = Work.new(category: "book", title: "The Book")

      # Assert
      # repeat
      expect(repeat_work.valid?).must_equal false
      expect(repeat_work.errors.messages).must_include :title
      expect(repeat_work.errors.messages[:title]).must_equal ["has already been taken"]
      # new work
      expect(works(:new_cat_work).valid?).must_equal true
      expect(works(:new_cat_work).errors.messages).must_be_empty
    end

    it "must have a category" do
      # Arrange
      works(:book).category = nil

      # Assert
      expect(works(:book).valid?).must_equal false
      expect(works(:book).errors.messages).must_include :category
      # note: even though they get the same message,
      # nil vs a wrong category still have to be tested separately
      expect(works(:book).errors.messages[:category]).must_equal ["must be book, movie, or album"]
    end

    it "accepts valid categories regardless of case, converting to downcase" do
      caps_work = Work.create(category: "MOVIE", title: "Movie")
      # Assert
      expect(caps_work.valid?).must_equal true
      expect(caps_work.errors.messages).must_be_empty
      expect(caps_work.category).must_equal 'movie'
    end

    it "rejects invalid category types as a safeguard" do
      # Arrange
      works(:book).category = 'FAKER'

      # Assert
      expect(works(:book).valid?).must_equal false
      expect(works(:book).errors.messages).must_include :category
      # note: even though they get the same message,
      # nil vs a wrong category still have to be tested separately
      expect(works(:book).errors.messages[:category]).must_equal ["must be book, movie, or album"]
    end

    # we know the behavior of integer typecasting
    # but we also want to document the behavior from a user POV
    it "converts float years to integers, strings to integer" do
      # try a float
      works(:book).publication_year = 2.44
      expect(works(:book).publication_year).must_equal 2

      # try a string
      works(:book).publication_year = 'NOTAYEAR'
      expect(works(:book).publication_year).must_equal 0

      # try a numerical string
      works(:book).publication_year = '1999'
      expect(works(:book).publication_year).must_equal 1999
    end
  end

  describe "custom methods" do
    before do
      @user = User.create(username: 'voter')
      @newer_work = Work.new(category: 'movie', title: 'A')
    end

    describe "spotlight" do
      before do
        Vote.delete_all # for this particular section we need to manipulate votes a certain way
      end
      it "returns nil if there are no works" do
        Work.delete_all
        assert_nil(Work.spotlight)
      end
      it "returns work with most votes" do
        # @work1.save
        # @work2.save

        Vote.create(work_id: works(:workBB).id, user_id: @user.id)

        expect(Work.spotlight).must_equal works(:workBB)
        expect(Work.spotlight.votes.count).must_equal 1
        expect(Work.spotlight.votes.count).must_equal works(:workBB).votes.count
      end
      it "returns work earlier in alphabet if top have same number of votes" do

        expect(Work.spotlight).must_equal works(:workBA)
        expect(Work.spotlight.votes.count).must_equal 0
        expect(Work.spotlight.votes.count).must_equal works(:workBB).votes.count
      end

      it "returns work updated more recently if same title (possible with diff. cat) and same number of votes" do
        sleep (1)
        @newer_work.save
        expect(Work.spotlight).must_equal @newer_work
        expect(Work.spotlight.votes.count).must_equal 0
        expect(Work.spotlight.votes.count).must_equal works(:workBA).votes.count
        expect(Work.spotlight.title).must_equal works(:workBA).title
      end
    end

    describe "sort_cat" do
      it 'returns empty array for when there are no works for a certain category' do
        Work.delete_by(category: 'book')
        expect(Work.sort_cat('book')).must_be_empty
        expect(Work.sort_cat('book')).must_be_kind_of Array
      end
      it 'returns an array of works in a category sorted by vote, most to least ' do
        # two book entries
        #@work1.save
        #@work2.save

        # vote for one
        Vote.create(work_id: works(:workBB).id, user_id: @user.id)

        # get sorted array
        sorted_books = Work.sort_cat('book')

        expect(sorted_books.length).must_equal Work.where(category: 'book').count
        expect(sorted_books.first).must_equal works(:workBB)
        expect(sorted_books.first.id).must_equal works(:workBB).id
        expect(sorted_books.first.votes.count).must_equal 1
        expect(sorted_books.last.votes.count).must_equal 0
      end

      it "sorts works with the same number of votes in ABC order" do
        Vote.delete_all # need to clear votes so all have same number
        # two book entries

        # get sorted array
        sorted_books = Work.sort_cat('book')

        expect(sorted_books.length).must_equal Work.where(category: 'book').count
        expect(sorted_books.first).must_equal works(:workBA)
        expect(sorted_books.first.id).must_equal works(:workBA).id
        expect(sorted_books.first.votes.count).must_equal 0
        expect(sorted_books.last.votes.count).must_equal 0
      end
    end

    # sort_cat is already tested, will just check for # num of elements and instance types
    describe "work_hash" do
      it "returns an hash with empty arrays of values if there are no works" do
        Work.delete_all
        empty_arrays = Work.work_hash
        expect(empty_arrays.length).must_equal 3
        empty_arrays.each {|cat, array| expect(array).must_be_empty}
      end
      it "returns a hash with keys matching to what category the array contains works of" do
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

