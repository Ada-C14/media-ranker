require "test_helper"

describe Vote do
  # let(:test_work) {
  #   Work.create(media: "test work", created_by: "test creator", published: 2020, description:"test description")
  # }

  describe "validations" do

    it "a user cannot vote for the same media twice"
  end

  describe "relationships" do

    before do
      @vote = votes(:vote4)
    end

    it " is valid with user and work" do
      expect(@vote.valid?).must_equal true
    end

    it "is invalid without user and work" do
      @vote.user = nil

      expect(@vote.valid?).must_equal false
    end

  end
end
