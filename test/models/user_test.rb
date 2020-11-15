require "test_helper"

describe User do
  describe "logging in" do
    it "validates that username is not blank" do
      user = User.new(username: "")
      user.username = nil

      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :username
      expect(user.errors.messages[:username]).must_equal ["can't be blank"]
    end

    it "validates that username is unique" do
      user = users(:nagai)
      user2 = User.create(username: 'Emily Nagai')

      expect(user2.valid?).must_equal false
      expect(user2.errors.messages[:username]).must_equal ["has already been taken"]
    end
  end
end
