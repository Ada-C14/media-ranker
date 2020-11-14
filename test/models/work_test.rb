require "test_helper"

describe Work do
  before do
    @work = works(:work1)
  end

  describe "instantiation" do
    it "can be instantiated" do
      expect(@work.valid?).must_equal true
    end
  end

  describe "validations" do
    it 'is valid when all fields are present' do
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it "is invalid without a title" do
      @work.title = nil
      result = @work.valid?
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it "is invalid with a repeating title in the same category and validation is not case sensitive" do
      work2 = works(:work2)
      work2.title = "work5"
      result = work2.valid?
      expect(result).must_equal false
    end

    it "is valid with a repeating title in the different category" do
      work2 = works(:work2)
      work2.title = "work1"
      result = work2.valid?
      expect(result).must_equal true
    end

    it "is invalid without a category" do
      @work.category = nil
      result = @work.valid?
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :category
    end
  end

  describe "relations" do
    it "can have many votes" do
      expect(@work.votes.count).must_equal 5

      expect {
        Vote.create!(work_id: @work.id, user_id: users(:user6).id)
      }.must_differ "@work.votes.count", 1

      @work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it "can have many users through votes" do
      votes(:vote1)
      votes(:vote2)

      @work.votes.each do |vote|
        voted_user = User.find_by(id: vote.user_id)
        expect(voted_user).must_be_instance_of User
      end
    end


  end

  describe "custom methods" do
    describe "top_ten" do
      it "returns an array of Works that have the top ten votes in each category" do
        top_movies = Work.top_ten(:movie)
        expect(top_movies).must_be_instance_of Array
        expect(top_movies.length).must_equal 10

        top_movies.each do |work|
          expect(work).must_be_instance_of Work
        end
      end

      it "returns the top ten works in descending fashion with the first work to have most votes" do
        top_work = works(:work2)
        top_votes = top_work.votes.count
        expect(Work.top_ten(:movie).first).must_equal top_work
        expect(Work.top_ten(:movie).first.votes.count).must_equal top_votes
      end

      it "returns an array of all works if there are less than 10 works in a category" do
        total_books = Work.where(category: :book).count
        top_books = Work.top_ten(:book)
        expect(top_books).must_be_instance_of Array
        expect(top_books.length).must_equal total_books

        top_books.each do |work|
          expect(work).must_be_instance_of Work
        end
      end

      it "returns an empty array if there are no works in a category" do
        Work.delete_all
        top_albums = Work.top_ten(:album)
        expect(top_albums).must_be_instance_of Array
        expect(top_albums.length).must_equal 0
      end
    end

    describe "spotlight" do
      it "returns one Work that has the most votes" do
        top_work = works(:work1)
        top_votes = top_work.votes.count
        expect(Work.spotlight).must_be_instance_of Work
        expect(Work.spotlight).must_equal top_work
        expect(Work.spotlight.votes.count).must_equal top_votes
      end

      it "returns nil when there are no works in database" do
        Work.delete_all
        expect(Work.count).must_equal 0
        expect(Work.spotlight).must_be_nil
      end
    end
  end
end
