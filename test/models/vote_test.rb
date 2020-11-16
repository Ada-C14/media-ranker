require "test_helper"

describe Vote do
  let (:vote) { Vote.first }

  it 'can be instantiated with the required fields' do
    expect(vote.valid?).must_equal true
    expect(vote).must_respond_to :user_id
  end

  describe 'relationships' do
    it 'belongs to a user' do
      vote
      expect(Work.find_by(id: vote.work_id)).must_be_instance_of Work
    end

    it 'belongs to a work' do
      vote
      expect(User.find_by(id: vote.user_id)).must_be_instance_of User
    end
  end
end
