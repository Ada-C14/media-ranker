require "test_helper"

describe User do
  describe "validations" do
    it "is invalid without a username" do
      user = User.create!(username: "testing")
      user.username = nil
      result = user.valid?
      expect(result).must_equal false
      expect(user.errors.messages).must_include :username
    end
  end
end

