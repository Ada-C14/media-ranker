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

end
