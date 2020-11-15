require "test_helper"

describe User do
  it "can be instantiated" do
    # Assert
    expect(users(:user).valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    user = User.first
    # Assert
    expect(user).must_respond_to :username
  end

  describe "relationships" do
    it "can have many votes" do
      # arrange

      # Assert
      expect(users(:user).votes.count).must_equal 2
      expect(votes(:vote).work).must_equal works(:book)
      expect(votes(:vote2).work).must_equal works(:workAA)
      users(:user).votes.each do |vote|
        expect(vote).must_be_instance_of Vote
        expect(vote.user_id).must_equal users(:user).id
      end
    end
    it "can get information of works the user voted for" do
      # Assert
      expect(users(:user).works.count).must_equal 2
      # check info
      expect(users(:user).works.find_by(title: "The Book")).must_equal works(:book)
      expect(users(:user).works.find_by(title: "A")).must_equal works(:workAA)
      users(:user).works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end

  end

  describe "validations" do
    it "must have a username" do
      # Arrange
      users(:user).username = nil

      # Assert
      expect(users(:user).valid?).must_equal false
      expect(users(:user).errors.messages).must_include :username
      expect(users(:user).errors.messages[:username]).must_equal ["can't be blank"]
    end
  end
end
