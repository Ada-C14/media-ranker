require "test_helper"

describe User do
  let (:new_user) {
    User.new(username: "user")
  }
  it "can be instantiated" do
    # Assert
    expect(new_user.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_user.save
    user = User.first
    # Assert
    expect(user).must_respond_to :username
  end

  describe "relationships" do

  end

  describe "validations" do
    it "must have a username" do
      # Arrange
      new_user.username = nil

      # Assert
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :username
      expect(new_user.errors.messages[:username]).must_equal ["can't be blank"]
    end
  end
end
