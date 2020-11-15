require "test_helper"

describe User do
  let (:new_user) {
    User.new(username: "potato")
  }

  it "can be instantiated" do
    expect(new_user.valid?).must_equal true
  end

  it "wont allow a new user to be created without a username" do
    new_user.username = nil

    expect(new_user.valid?).must_equal false
  end

  describe "relationships" do

  end
end
