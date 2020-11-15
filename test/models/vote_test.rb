require "test_helper"

describe Vote do
  describe "relations" do
    before do
      @vote = votes(:one)
    end
    it "belongs to a user" do
      expect(@vote.user).must_be_instance_of User
    end

    it "belongs to a work" do
      expect(@vote.work).must_be_instance_of Work
    end
  end

  describe "validations" do
    before do
      @work = Work.create(category: "movie", title: "s", creator: "r", publication_year: "1990", description: "u")
      @user = User.create(username: "test_name")
      @vote = Vote.new(user: @user, work: @work)
    end

    it "is valid when all fields are present" do
      expect(@vote.valid?).must_equal true
    end
  end
end
