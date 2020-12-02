require "test_helper"

describe User do
  describe 'validations' do
    before do
      # Arrange
      @user = User.new(name: 'churro', date_joined: Date.today)
      @work = Work.new(category: "movie", title: "Matrix")
      @vote = Vote.new(user: @user, work: @work)
    end

    it 'is valid when all fields are present' do
      # Assert
      expect(@user.valid?).must_equal true
    end

    it 'is invalid without a name' do
      # Arrange
      @user.name = nil
      # Assert
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :name
      expect(@user.errors.messages[:name]).must_equal ["can't be blank"]
    end


    it 'is invalid without a joined date' do
      @user.date_joined = nil
      # Assert
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages.include?(:date_joined)).must_equal true
    end
  end

  describe "relationships" do
    before do
      # Arrange
      @user = User.new(name: 'churro', date_joined: Date.today)
      @work = Work.new(category: "movie", title: "Matrix")
      @vote = Vote.new(user: @user, work: @work)
    end

    it "has votes" do
      # assert
      expect(@user.votes).must_equal @vote
    end
  end
end