require "test_helper"

describe Vote do
  describe "validations" do
    it "valid with user and work" do
      vote = votes(:vote3)
      expect(vote.valid?).must_equal true
    end

    it "there can be multiple votes by the same user for different work" do
      vote1 = votes(:vote1)
      vote2 = votes(:vote2)
      expect(vote1.valid?).must_equal true
      expect(vote2.valid?).must_equal true

      vote1.user = vote2.user
      expect(vote1.valid?).must_equal true
    end

    it "votes are invalid if theyre by the same user for the same work" do
      vote1 = votes(:vote1)
      vote2 = votes(:vote2)
      expect(vote1.valid?).must_equal true
      expect(vote2.valid?).must_equal true

      vote1.work = vote2.work
      expect(vote1.valid?).must_equal false
      expect(vote1.errors.messages).must_include :work_id
    end

    it "invalid without user" do
      vote = votes(:vote1)
      vote.user_id = nil
      expect(vote.valid?).must_equal false
      expect(vote.errors.messages).must_include :user
    end

    it "invalid without work" do
      vote = votes(:vote1)
      vote.work_id = nil
      expect(vote.valid?).must_equal false
      expect(vote.errors.messages).must_include :work
    end
  end

  describe "relations" do
    it "a vote must have one user" do
      vote = votes(:vote3)
      expect(vote.user.name).must_equal "Rosalba Okuneva"
    end

    it "a vote must have one work" do
      vote = votes(:vote3)
      expect(vote.work.title).must_equal "work3 title"
    end
  end
end