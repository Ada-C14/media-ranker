require "test_helper"

describe Vote do
  let(:new_vote) {
    user4 = User.create(username: "user4")
    album1 =Work.create(media: "album", title: "dakiti", created_by: "bad bunny ", published: "2020", description: "latin dance song")
    Vote.new(user: user4, work: album1)
  }

  it "can be instantiated" do  #Passing
    expect(new_vote.valid?).must_equal true
  end

  describe "relationships" do
    before do
      @vote = votes(:vote4)
    end

    it "belongs to a user" do  #Passing
      expect(@vote.user).must_be_instance_of User
    end

    it " belongs to a work" do #Passing
      expect(@vote.work).must_be_instance_of Work
    end

  end

  describe "validations" do
    before do
      @user= User.create(username: "test")
      @work =Work.create(media: "movie", title: "moana", created_by: "disney", published: "2016", description: "cute movie")
      @vote =Vote.new(user: @user, work: @work)
    end

    it "is invalid without user_id" do  #Passing
      @vote.user_id = nil
      expect(@vote.valid?).must_equal false
    end

    it "is invalid without work_id" do  #Passing
      @vote.work_id = nil
      expect(@vote.valid?).must_equal false
    end

  end
end
