require "test_helper"

describe User do
  describe "validations" do

    it "can create a user with a username" do
      @user = User.create!(username: "boop")

      result = @user.valid?
      expect(result).must_equal true
      expect(@user.username).must_equal "boop"
    end

    it "will not create a user with a duplicate username" do
      @new_user = User.create!(username: "boop")

      result = @new_user.valid?
      expect(result).must_equal false
    end

    it "must have a username" do
      @user = User.create!(username: nil)

      result = @user.valid?
      expect(result).must_equal false
      # expect error message must be "Username has already been taken"
    end
  end

  describe "relationships" do

    it "user can have many votes" do
      vote_1 = Vote.create!(username: user1, work: :book_one)
      vote_2 = Vote.create!(username: user1, work: :book_two)

      expect(vote_1.valid?).must_equal true
      expect(vote_2.valid?).must_equal true
      expect(user1.votes.count).must_equal 3
    end
  end
end
