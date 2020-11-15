require "test_helper"

# Add Relations Tests in Wave 2
# Add Fixtures Later
# New? Create?

describe User do
  it "is valid when all required fields are present" do
    # Arrange
    @user = User.new(user_name: "me")

    # Act
    created_user = @user.valid?

    # Assert
    expect(created_user).must_equal true
  end

  it "is invalid without title" do
    # Arrange
    @user = User.new

    #Act
    created_user = @user.valid?

    # Assert
    expect(created_user).must_equal false
    expect(@user.errors.messages).must_include :user_name
  end
end
