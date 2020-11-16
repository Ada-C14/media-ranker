require "test_helper"

describe User do
  before do
    # Arrange
    @user = users(:me)
  end

  describe 'relationships' do
    it 'can be added to a vote' do
      vote = Vote.create(work: works(:aguirre), user: @user)
      expect(vote.user.name).must_equal "iris-lux"
    end

    it 'can access work thru user' do
      vote = Vote.create(work: works(:vertigo), user: @user)
      expect(vote.user.works.all.map{|work| work.title}).must_include "Vertigo"
    end

    it 'deleting user will delete related vote' do
      Vote.create(work: works(:vertigo), user: @user)
      expect{
        User.destroy(@user.id)
      }.must_change "Vote.count", -1
    end
  end

  describe 'validations' do

    it 'is valid when all fields are present' do
      result = @user.valid?

      expect(result).must_equal true
    end

    it 'will be invalid if user name has already been taken' do
      repeated_user = User.new(name: "iris-lux")

      expect(repeated_user.valid?).must_equal false
      expect(repeated_user.errors.messages).must_include :name
      expect(repeated_user.errors.messages[:name][0]).must_equal "has already been taken"
    end


    it 'will be invalid if name is blank' do
      @user.name = nil

      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :name
      expect(@user.errors.messages[:name][0]).must_equal "can't be blank"
    end

  end
end
