require "test_helper"

describe User do
  describe 'validation' do
    before do
      @user = users(:lisa)
    end

    it 'is valid with username' do
      expect(@user.valid?).must_equal true
    end

    it 'is invalid without username' do
      @user.username = nil
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :username
    end
  end

  describe 'relations' do
    before do
      @user = users(:julian)
      @user.save
      @work = works(:jieyou)
      @work.save
    end

    it 'has many votes' do
      Vote.create!(user_id: @user.id, work_id: @work.id)
      expect(@user.votes.first.work_id).must_equal @work.id
    end
  end
end
