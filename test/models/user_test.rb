require "test_helper"

describe User do
  describe 'validations' do
    it 'is valid when all fields are present' do
      # Arrange
      user = users(:john)

      # Act
      result = user.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a username' do
      # Arrange
      user = users(:john)
      user.username = nil
    
      # Act
      result = user.valid?
    
      # Assert
      expect(result).must_equal false
      expect(user.errors.messages).must_include :username
    end

    it 'is invalid with a non-unique username' do
      # Arrange
      unique_user = User.create!(username: 'Registered user', joined: "Nov 13, 2020")
      users(:john).username = unique_user.username

      # Act
      result = users(:john).valid?

      # Assert
      expect(result).must_equal false
      expect(users(:john).errors.messages).must_include :username
    end
  end

  describe 'relations' do
    it "has many votes" do
      skip
    end

    it "have many works thru votes" do
      skip
    end
  end

end
