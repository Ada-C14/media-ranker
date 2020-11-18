require "test_helper"

describe Vote do
  before do
    @user = User.create(username: 'first_user')
    @work = Work.create(title: 'New Work', category: 'book')
    @vote = Vote.create(user_id: @user.id, work_id: @work.id)
  end

  describe 'Relationships' do
    it 'belongs to a User' do
      expect(@vote.work_id).must_equal @work.id
    end

    it 'belongs to a Work' do
      expect(@vote.user_id).must_equal @user.id
    end

  end

  describe 'Validations' do

    it 'is valid when all both user and work are present' do
      expect(@vote.valid?).must_equal true
    end

    it 'fails validation when there is no work' do
      @vote.work_id = nil

      expect(@vote.valid?).must_equal false
    end

    it 'fails validation when there is no user' do
      @vote.user_id = nil

      expect(@vote.valid?).must_equal false
    end

    it 'fails validation when user has already voted on this work' do
      new_vote = Vote.create(user_id: @user.id, work_id: @work.id)

      expect(new_vote.valid?).must_equal false
    end
  end
end
