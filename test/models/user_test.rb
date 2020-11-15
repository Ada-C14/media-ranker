require "test_helper"

describe User do

  before do
    @user1 = users(:user1)
    @user2 = users(:user2)
    @user3 = users(:user3)

    @book1 = works(:book1)
    @book2 = works(:book2)
    @book3 = works(:book3)
    @book4 = works(:book4)

    @movie1 = works(:movie1)
    @movie2 = works(:movie2)
    @movie3 = works(:movie3)
    @movie4 = works(:movie4)
    @movie5 = works(:movie5)
    @movie6 = works(:movie6)
    @movie7 = works(:movie7)
    @movie8 = works(:movie8)
    @movie9 = works(:movie9)
    @movie10 = works(:movie10)
    @movie11 = works(:movie11)
    @movie12 = works(:movie12)
  end

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
      @user = User.create(username: nil)

      result = @user.valid?
      expect(@user.errors).must_include :username
    end
  end

  describe "relationships" do

    it "user can have many votes" do
      expect(@user1.votes.count).must_equal 7
    end

  end
end
