require 'test_helper'

describe Work do

  it "can be instantiated" do
    expect(votes(:vote_2).valid?).must_equal true
  end

  it "has required fields" do
    work = Work.first
    expect(work).must_respond_to :category
    expect(work).must_respond_to :title
  end

  describe "has valid relationships" do
    it "can have many votes" do
      expect(works(:work_2).votes.first).must_be_instance_of Vote
      expect(works(:work_2).votes.last).must_be_instance_of Vote
      expect(works(:work_2).votes.count).must_equal 1
      expect(votes(:vote_1).user).must_equal users(:user_1)
    end
  end
end
