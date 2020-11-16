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
        user_id = User.create!(username: "Hermione").id
        pre_vote = Vote.connect_work_user(work_id, user_id)

        expect(pre_vote).must_be_instance_of Vote
        expect(pre_vote.valid?).must_equal true
      end

      it "returns something if one or both of the fields are empty" do
        work_id = works(:hp1).id
        # expect(Vote.connect_work_user(work_id, -1)).must_be_instance_of Vote
        vote =  Vote.connect_work_user(work_id, -1)
        expect(vote.valid?).must_equal false
      end
    end

    describe "format_date" do
      it "returns a formatted date string based on the created by date" do
        date = DateTime.now.utc.strftime("%b %d, %Y")
        user = User.create!(username: "test date")
        work = works(:hp1)
        vote = Vote.create!(work_id: work.id , user_id: user.id )
        expect(vote.format_date).must_equal date
        expect(vote.format_date).must_be_instance_of String
      end
    end

  end
  describe "relationships" do
    before do
      @user = User.create!(username: "user")
      @work = works(:hp2)
      @vote = Vote.create!(work_id: @work.id, user_id: @user.id)
    end

    it "belongs to a user" do
      expect(@vote.user).must_be_instance_of User
      expect(@vote.user).must_equal @user

    end

    it "it belongs to a work" do
      expect(@vote.work).must_be_instance_of Work
      expect(@vote.work).must_equal @work
    end
  end
end
