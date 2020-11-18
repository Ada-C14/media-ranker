require "test_helper"

# Add Relations Tests in Wave 2
# Add Fixtures Later
# New? Create?

describe User do

  describe "validations" do
    it "can be instantiated and is valid when all required fields are present" do
      # Arrange
      @user = User.new(user_name: "me")

      # Act
      created_user = @user.valid?

      # Assert
      expect(created_user).must_equal true
    end

    it "is invalid without user name" do
      # Arrange
      @user = User.new

      #Act
      created_user = @user.valid?

      # Assert
      expect(created_user).must_equal false
      expect(@user.errors.messages).must_include :user_name
    end
  end

  describe "relationships" do
    it "can vote for multiple works" do
      # Arrange user3 in users.yml
      user = users(:user3)

      # Assert relationship to vote model, 3 votes by user3 in votes.yml
      expect(user.votes.count).must_equal 3
    end
  end
end
