require "test_helper"

describe User do
  describe 'relations' do
    it 'can have many votes' do
      #use fixtures yml data
      user = users(:user0)

      expect(user.votes.count).must_equal 4
    end

    it 'can access works through votes' do
      user = users(:user0)

      expect(user.works.count).must_equal 4
    end
  end

  describe 'validations' do
    before do
      # Arrange a valid user
      @user = User.create!(username: 'Username')
    end

    it 'is valid when all fields are present' do
      # Act
      result = @user.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without username' do
      @user.username = nil
      result = @user.valid?

      expect(result).must_equal false
    end

    it 'is invalid if username already exists' do
      new_user = User.new(username: 'Username')

      expect(new_user.valid?).must_equal false
      # if do new_user.save, then expect validation error?
    end
  end

end
