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
    end
end

