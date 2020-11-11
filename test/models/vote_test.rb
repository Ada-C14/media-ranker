require "test_helper"

describe Vote do
  before do
    @user = users(:miso)
    @work = works(:cowboy)
  end
  let (:new_vote) {
    Vote.new(user_id: @user.id ,
             work_id: @work.id
             )
  }
  describe "validations" do

    it "is valid when all the fields are present" do
      new_vote.save

      expect(new_vote.valid?).must_equal true

    end

    it "is invalid if the user has already voted for the work" do
      Vote.create(user_id: @user.id, work_id: @work.id)

      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_include :work_id
      expect(new_vote.errors.messages[:work_id].include?("has already been taken")).must_equal true

    end

  end
  describe "relations" do
    it "can set the work" do
      vote = Vote.new
      vote.work = works(:cowboy)
      expect(vote.work_id).must_equal works(:cowboy).id

    end

    # TODO: check if I need the "has a work/user" tests

    it "can set the user" do
      vote = Vote.new
      vote.user = users(:miso)
      expect(vote.user_id).must_equal users(:miso).id

    end
  end
end
