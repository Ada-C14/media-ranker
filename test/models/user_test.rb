require "test_helper"

describe User do
  before do
    @work = works(:test_work)
    @user = User.create!(name: "test user")
    @vote = Vote.create!(user_id: @user.id, work_id: @work.id)
  end

  describe "instantiation" do
    it "can be instantiated" do
      expect(@user.valid?).must_equal true
    end

    it "will have the required fields" do
      [:name].each do |field|
        expect(@user).must_respond_to field
      end
    end
  end

  describe "relations" do
    it "can have many votes" do
      Vote.create!(user_id: @user.id, work_id: @work.id)
      expect(@user.votes.count).must_equal 2
    end
  end

end
