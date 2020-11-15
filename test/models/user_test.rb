require "test_helper"

describe User do
  it "will have the required fields" do
    # Arrange
    user = User.first
    # Assert
    expect(user).must_respond_to :username
  end

end
