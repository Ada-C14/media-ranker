require "test_helper"

describe User do
  before do
    @user = User.new(
        {
            username: "Mona"
        }
    )
  end

  it "has the required field" do
    @user.save
    user = User.find_by(username: "Mona")
    [:username].each do |field|
      expect(user).must_respond_to field
    end
  end

  describe "relations" do
    it "has many votes" do
      test_user = users(:user_2)
      expect(test_user.votes.count).must_equal 3
      @user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it "has many works through votes" do
      user = users(:user_1)
      expect(user.works.count).must_equal 6
      user.works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end
  end
end
