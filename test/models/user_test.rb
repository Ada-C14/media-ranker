require "test_helper"

describe User do
    describe 'validations' do
      before do
        # Arrange
        @user = users(:test_user)
      end

      it 'is valid when all fields are present' do
        # Act
        result = @user.valid?

        # Assert
        expect(result).must_equal true
      end

      it 'is not valid when fields are not present' do
        @user = User.new()

        result = @user.valid?

        expect(result).must_equal false
      end
    end
end

