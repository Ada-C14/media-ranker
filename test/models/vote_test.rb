require "test_helper"

describe Vote do
  describe "relation" do
    it "belongs to a User" do
      vote = votes(:pooh_dune)

      expect(vote.user).must_be_kind_of User
    end

    it "belongs to a Work" do
      vote = votes(:pooh_dune)

      expect(vote.work).must_be_kind_of Work
    end
  end

  describe "validations" do
    it "must have a user" do
      work = works(:dune)
      vote = Vote.create(work: work)

      expect(vote.errors.messages).must_include :user_id
      expect(vote.errors.messages[:user_id]).must_equal ["can't be blank"]
    end

    it "must have an existing user" do
      user = users(:pooh)
      vote = votes(:pooh_dune)

      user.destroy

      expect(vote.valid?).must_equal false
      expect(vote.errors.messages).must_include :user
      expect(vote.errors.messages[:user]).must_equal ["must exist"]
    end

    it "must have a work" do
      user = users(:pooh)
      vote = Vote.create(user: user)

      expect(vote.errors.messages).must_include :work_id
      expect(vote.errors.messages[:work_id]).must_equal ["can't be blank"]
    end

    it "must have an existing work" do
      work = works(:dune)
      vote = votes(:pooh_dune)

      work.destroy

      expect(vote.valid?).must_equal false
      expect(vote.errors.messages).must_include :work
      expect(vote.errors.messages[:work]).must_equal ["must exist"]
    end

    it "must have a unique user and work" do
      vote = votes(:pooh_dune)
      user = vote.user
      work = vote.work

      duplicate_vote = Vote.create(user: user, work: work)

      expect(duplicate_vote.valid?).must_equal false
      expect(duplicate_vote.errors.messages).must_include :user
      expect(duplicate_vote.errors.messages[:user]).must_equal ["has already voted for this work"]
    end
  end
end
