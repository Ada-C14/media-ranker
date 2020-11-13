require "test_helper"

describe Vote do
  describe "validations" do
    it "it is valid with all fields" do
      work = works(:hp1)
      user = User.create!(username: "Jasmine")
      vote = Vote.new(work_id: work.id, user_id: user.id)
      expect(vote.valid?).must_equal true

    end

    it "is invalid without work_id" do
      vote = Vote.new(work_id: works(:hp1).id)
      expect(vote.valid?).must_equal false
    end

    it "is invalid without user_id" do
      vote = Vote.new(user_id: users(:harry).id)
      expect(vote.valid?).must_equal false
    end

    it "it is invalid if combo of work_id and user_id are not unique" do
      work = works(:hp1)
      user = users(:harry)
      vote = votes(:vote_1) # is linked to work and user in fixture
      vote_copy = Vote.new(work_id: work.id, user_id: user.id)
      expect(vote_copy.valid?).must_equal false
    end

  end
  describe "custom methods" do
    describe "connect work and user" do
      it "returns vote object given a work_id and user_id" do
        work_id = works(:hp1).id
        user_id = User.new(username: "Hermione").id
        expect(Vote.connect_work_user(work_id, user_id)).must_be_instance_of Vote
      end
    end

  end
  describe "relationships" do
    it "belongs to a user" do
      vote = votes(:vote_1)
      expect(vote.user).must_be_instance_of User
    end

    it "it belongs to a work" do
      vote = votes(:vote_2)
      expect(vote.work).must_be_instance_of Work
    end
  end
end
