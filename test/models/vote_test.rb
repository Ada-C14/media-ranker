require "test_helper"

describe Vote do
  before do
    @vote = votes(:vote_1)
  end
  describe "relationships" do
    it "can have a work" do
      expect(@vote.work.title).must_equal "The Crying of Lot 49"
    end

    it "can have a user" do
      expect(@vote.user.name).must_equal "iris-lux"
    end
  end

  describe "validations" do

    it 'will be valid if all fields are present' do
      expect(@vote.valid?).must_equal true
    end

    it 'will be invalid if user has already voted on work' do
      repeated_vote = Vote.new(work: works(:lot_49), user: users(:me))

      expect(repeated_vote.valid?).must_equal false
      expect(repeated_vote.errors.messages).must_include :user
      expect(repeated_vote.errors.messages[:user][0]).must_equal "has already voted for this work"
    end

    it 'will be valid if same user votes on different work' do
      repeated_vote = Vote.new(work: works(:book_e), user: users(:me))

      expect(repeated_vote.valid?).must_equal true

    end

    it 'will be valid if different user votes on same work' do
      repeated_vote = Vote.new(work: works(:lot_49), user: users(:u1))

      expect(repeated_vote.valid?).must_equal true

    end
  end
end
