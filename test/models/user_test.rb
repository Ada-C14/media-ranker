require "test_helper"

describe User do
  describe "validation" do

    before do
      @user = User.create(username: 'Username')
      @bad_user = User.create(username: "")
    end

    it "must have username to be valid " do  #Passing
      result = @user.valid?

      expect(result).must_equal true
    end
  end

  it "is invalid without a username" do
    #Act
    bad_result = @bad_user.valid?

    expect(bad_result).must_equal false

  end

  it "is invalid if username already exists" do
    new_user = User.new(username:'Username')

    expect(new_user.valid?).must_equal false
  end

  # describe "relationships" do
  #
  # end
  #
  # it "can have many votes" do
  #
  # end
end
