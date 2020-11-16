require 'test_helper'

describe Vote do
  describe 'relationship' do

    it 'belongs to one user - requires user_id field' do
      # test each entry from votes.yml file:
      votes.each do |vote|
        expect(vote).must_respond_to :user_id
        expect(vote.user).must_be_instance_of User
      end
    end

    it 'fails without a user_id (required field)' do
      invalid_vote = Vote.new(user_id: '')
      expect(invalid_vote.valid?).must_equal false
    end

    it 'belongs to one piece of work/media' do
      # test each entry from votes.yml file:
      votes.each do |vote|
        expect(vote.work).must_be_instance_of Work
        expect(vote).must_respond_to :work_id
      end
    end

    it 'fails without a work_id (required field)' do
      invalid_vote = Vote.new(work_id: '')
      expect(invalid_vote.valid?).must_equal false
    end

  end
end
