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

  describe 'associations' do
    before do
      # Arrange
      @user = User.create!(name: 'churro', date_joined: Date.today) #bang throws an error/exception if it fails vs false with create
      @work = Work.create!(category: "movie", title: "Matrix")
      @vote = Vote.new(user_id: @user.id, work_id: @work.id)
    end

    it 'has a work' do
      expect(@vote.work).must_equal @work
    end

    it 'has a user' do
      expect(@vote.user).must_equal @user

    end
  end
end



