require "test_helper"

describe Vote do
  describe 'validations' do
    before do
      # Arrange
      @user = User.new(name: 'churro', date_joined: Date.today)
      @work = Work.new(category: "movie", title: "Matrix")
      @vote = Vote.new(user: @user, work: @work)
    end

    it 'is valid when all fields are present' do
      # Act
      result = @vote.valid?
      # Assert
      expect(result).must_equal true
    end
  end
end



