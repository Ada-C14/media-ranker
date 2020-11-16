require 'test_helper'

class WorkTest < ActiveSupport::TestCase
  describe Work do
    let (:valid_work) {
      works(:movie)
    }
    it "can be instantiated" do
      expect(valid_work.valid?).must_equal true
      expect(valid_work).must_be_instance_of Work
    end


    it "will have the required fields" do
      expect(valid_work.category).wont_be_nil
      expect(valid_work.title).wont_be_nil
      expect(valid_work.creator).wont_be_nil
      expect(valid_work.publication_year).wont_be_nil
      expect(valid_work.description).wont_be_nil

      work_attributes = [:category, :title, :creator, :publication_year, :description]

      work_attributes.each do |attribute|
        expect(valid_work).must_respond_to attribute
      end
    end

    describe "relationships" do
      it "can have many votes" do
        # Arrange
        valid_movie_work = works(:movie)
        valid_album_work = works(:album)
        valid_book_work = works(:book)

        valid_user = users(:user1)
        valid_user2 = users(:user2)


        # Act
        valid_vote1 = Vote.create(user: valid_user, work: valid_movie_work)
        valid_vote2 = Vote.create(user: valid_user, work: valid_album_work)
        valid_vote3 = Vote.create(user: valid_user, work: valid_book_work)
        # Two votes for book
        valid_vote4 = Vote.create(user: valid_user2, work: valid_book_work)

        # Assert
        [valid_vote1, valid_vote2, valid_vote3, valid_vote4].each do |vote|
          expect(vote).must_be_instance_of Vote
        end

        expect(valid_movie_work.votes.count).must_equal 1
        expect(valid_album_work.votes.count).must_equal 1
        expect(valid_book_work.votes.count).must_equal 2
      end
    end

    describe "validations" do
      it "must have a category" do
        work_with_nil_category = Work.create(
            category: nil,
            title: "Test movie",
            creator: "Test movie creator",
            publication_year: 2000,
            description: "Test movie description"
        )

        expect(work_with_nil_category.valid?).must_equal false
        expect(work_with_nil_category.errors.messages).must_include :category
        expect(work_with_nil_category.errors.messages[:category]).must_equal ["can't be blank"]
        assert_operator work_with_nil_category.errors.count, :>, 0
      end

      it "must have a title" do
        work_with_nil_title = Work.create(
            category: "album",
            title: nil,
            creator: "Test album creator",
            publication_year: 2001,
            description: "Test album description"
        )

        expect(work_with_nil_title.valid?).must_equal false
        expect(work_with_nil_title.errors.messages).must_include :title
        expect(work_with_nil_title.errors.messages[:title]).must_equal ["can't be blank"]
        assert_operator work_with_nil_title.errors.count, :>, 0
      end


      it "doesn't have to have creator, publication year, or description" do
        nil_creator_year_desc = Work.create(
            category: "album",
            title: "Test album title",
            creator: nil,
            publication_year: nil,
            description: nil
        )
        expect(nil_creator_year_desc.valid?).must_equal true
      end
    end

    describe "custom methods" do
      describe "spotlight" do
        it "returns work with most votes" do
          # Destroy all existing votes
          Vote.destroy_all

          # Create a vote for movie
          Vote.create(work: works(:movie), user: users(:user1))

          # Create 2 votes for movie2 from existing users
          valid_user1 = users(:user1)
          valid_user2 = users(:user2)

          Vote.create(work: works(:movie2), user: valid_user1)
          Vote.create(work: works(:movie2), user: valid_user2)

          # Spotlight must be movie 2
          expect(Work.spotlight).must_equal works(:movie2)
          expect(Work.spotlight).wont_be_nil
        end
      end

      describe "top_ten" do
        describe "top_ten_movies" do
          it "should only have movie as its category" do
            Work.top_ten("movie").each do |work|
              expect(work.category).must_equal "movie"
            end
          end

          it "should return a top ten list of movies sorted by ascending vote count" do
            # Destroy all existing votes
            Vote.destroy_all
            # Create 3 unique votes for movie one (3 separate users)
            Vote.create(work: works(:movie), user: users(:user1))
            Vote.create(work: works(:movie), user: users(:user2))
            Vote.create(work: works(:movie), user: users(:user3))

            # Create 2 unique votes for movie two
            Vote.create(work: works(:movie2), user: users(:user1))
            Vote.create(work: works(:movie2), user: users(:user2))

            # Create 1 vote for movie three
            Vote.create(work: works(:movie3), user: users(:user1))


            # Check to make sure votes are accurate
            expect(works(:movie).votes.count).must_equal 3
            expect(works(:movie2).votes.count).must_equal 2
            expect(works(:movie3).votes.count).must_equal 1

            # Check top ten list order
            expect(Work.top_ten("movie").first).must_equal works(:movie)
            expect(Work.top_ten("movie").last).must_equal works(:movie3)
            expect(Work.top_ten("movie")).wont_be_nil

          end

          it "should return an empty list if the category has no works" do
            # Destroy all existing works
            Work.destroy_all
            expect(Work.count).must_equal 0
            # Since Work and Votes are associated, when work is destroyed, the associated votes should also be destroyed.
            expect(Vote.count).must_equal 0

            expect(Work.top_ten("movie")).must_be_empty
            expect(Work.top_ten("album")).must_be_empty
            expect(Work.top_ten("book")).must_be_empty
          end
        end
      end
    end
  end
end
