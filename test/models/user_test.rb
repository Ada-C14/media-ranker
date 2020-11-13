require "test_helper"

describe User do
  describe "validations" do
    before do
      @user = User.new(username: "ringolingo")
    end

    it "creates a user when given valid input" do
      success = @user.valid?

      expect(success).must_equal true
    end

    it "won't create a user without a username" do
      @user.username = nil

      success = @user.valid?

      expect(success).must_equal false
    end

    it "won't create a user with a repeat name" do
      @user.save
      clone_user = User.new(username: "ringolingo")

      success = clone_user.valid?

      expect(success).must_equal false
    end
  end
end
