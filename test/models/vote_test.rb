require "test_helper"

describe Vote do
  it 'can be instantiated' do
    (Vote.new).must_be_kind_of Vote
  end

  it "will have the required fields" do
    vote = votes(:someone_voted)
    [:user_id, :work_id].each do |check|
      expect(vote).must_respond_to check
    end
  end

  describe 'relationships' do
    it 'belongs to a user' do
      expect(votes(:someone_voted).user).must_be_instance_of User
      expect(votes(:someone_voted).user.name).must_equal 'First'
    end

    it 'belongs to a work' do
      expect(votes(:someone_voted).work).must_be_instance_of Work
      expect(votes(:someone_voted).work.title).must_equal 'Books Are The Best'
    end

  end
end
