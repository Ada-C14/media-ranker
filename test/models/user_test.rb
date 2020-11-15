require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  describe User do
    let (:user) {
      users(:user1)
    }
    it "can be instantiated" do
      # Assert
      expect(user.valid?).must_equal true
      expect(user).must_be_instance_of User
    end

    it "will have the required fields" do
      # Assert
      expect(user.username).wont_be_nil
      expect(user).must_respond_to :username
    end

    describe "relationships" do
      it "can have many votes" do
        # Arrange
        valid_movie_work = works(:movie)
        valid_album_work = works(:album)
        valid_book_work = works(:book)

        valid_user = users(:user1)

        # Act
        valid_vote1 = Vote.create(user: valid_user, work: valid_movie_work)
        valid_vote2 = Vote.create(user: valid_user, work: valid_album_work)
        valid_vote3 = Vote.create(user: valid_user, work: valid_book_work)

        # Assert
        [valid_vote1, valid_vote2, valid_vote3].each do |vote|
          expect(vote).must_be_instance_of Vote
        end

        expect(user.votes.count).must_equal 3
      end
    end

    describe "validations" do
      it "must have a category" do
        # Arrange
        user_not_found = User.create(username: nil)
        # Assert
        expect(user_not_found.valid?).must_equal false
        expect(user_not_found.errors.messages).must_include :username
        expect(user_not_found.errors.messages[:username]).must_equal ["can't be blank"]
      end
    end
  end
end
