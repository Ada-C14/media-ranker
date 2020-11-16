require "test_helper"

describe Vote do
  before do
    @work = works(:jieyou)
    @work.save
    @user = users(:lisa)
    @user.save
    @vote = Vote.new(user_id: @user.id, work_id: @work.id)
  end

  describe 'validations' do
    it 'is valid when all fields are present' do
      expect(@vote.valid?).must_equal true
    end

    it 'is invalid without a user_id' do
      @vote.user_id = nil
      expect(@vote.valid?).must_equal false
    end

    it 'is invalid without a work_id' do
      @vote.work_id = nil
      expect(@vote.valid?).must_equal false
    end
  end


  describe 'relations' do
    it 'has an user' do
      @vote.save
      expect(@vote.user_id).must_equal @user.id
    end

    it 'has a work' do
      @vote.save
      expect(@vote.work_id).must_equal @work.id
    end

  end
end
