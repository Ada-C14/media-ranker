require "test_helper"

describe Vote do
  describe 'validations' do
    it "can be instantiated" do
      vote = votes(:vote_one)
      expect(vote.valid?).must_equal true
    end

    it 'cannot be instantiated when given invalid work or user id' do
      vote = Vote.new
      expect(vote.valid?).must_equal false
    end
  end
  describe 'relationships' do
    it 'belongs to a Work' do
      vote = votes(:vote_one)
      Work.all.each do |work|
        if work.id == vote.work_id
          expect(work).must_be_instance_of Work
          expect(vote.work_id).must_equal work.id
        end
      end
    end
    it 'belongs to a User' do
      vote = votes(:vote_one)
      User.all.each do |user|
        if user.id == vote.user_id
          expect(user).must_be_instance_of User
          expect(vote.user_id).must_equal user.id
        end
      end
    end
  end
end
