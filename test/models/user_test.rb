require "test_helper"

describe User do
  describe 'validations' do
    before do
      # Arrange
      @user = User.new(name: 'churro', date_joined: Date.today)
    end

    it 'is valid when all fields are present' do
      # Act
      result = @user.valid?
      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a name' do
      # Arrange
      @user.name = nil
      # Assert
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages.include?(:name)).must_equal true
    end

    it 'is invalid when username is not unique' do
      User.create!(name: @user.name, date_joined: Date.today)
      # Assert
      expect(@user.valid?).must_equal false
    end

    it 'is invalid without a joined date' do
      @user.date_joined = nil
      # Assert
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages.include?(:date_joined)).must_equal true
    end
  end
end