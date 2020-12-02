require "test_helper"

describe Work do
  describe 'validations' do
    before do
      # Arrange
      @work = Work.new(category: 'album', title: 'Nevermind')
    end

    it 'is valid when all fields are present' do
      # Act
      result = @work.valid?
      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a title' do
      # Arrange
      @work.title = nil
      # Assert
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages.include?(:title)).must_equal true
    end

    it 'is invalid when title is not unique' do
      Work.create(title: @work.title, creator: @work.creator)
      # Assert
      expect(@work.valid?).must_equal false
    end
  end

  describe 'associations' do
    before do
      # Arrange
      @user = User.create!(name: 'churro', date_joined: Date.today) #bang throws an error/exception if it fails vs false with create
      @work = Work.create!(category: "movie", title: "Matrix")
      @vote = Vote.new(user_id: @user.id, work_id: @work.id)
    end

    it 'has votes' do
      expect(@work.votes).must_equal @vote
    end
  end
end
