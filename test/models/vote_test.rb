require "test_helper"

describe Vote do
  describe "relations" do
    before do
      @vote = votes(:vote0)
    end

    it 'is valid with a user and work' do
      expect(@vote.valid?).must_equal true
    end

    it 'is invalid without a user' do
      @vote.user = nil

      expect(@vote.valid?).must_equal false
    end

    it 'must have a work' do
      @vote.work = nil

      expect(@vote.valid?).must_equal false
    end
  end

  describe 'validations' do
    it 'a user cannot vote for the same work twice' do
      user = users(:user0)
      work = works(:album0)
      new_vote = Vote.new(user: user, work: work)

      expect(new_vote.valid?).must_equal false
    end
  end
end
