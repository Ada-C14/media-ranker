require "test_helper"

describe User do
  let(:new_user){
    User.new(username: "newuser")
  }
  
  it "can be instantiated" do
    expect(new_user.valid?).must_equal true
  end 

  describe "validation" do
    before do
      @user = User.new(username: "test_user")
    end

    it "must have username to be valid " do  #Passing
      result = @user.valid?
      expect(result).must_equal true
    end

    it "is invalid without a username" do  #Passing
      @user.username = nil
      expect(@user.valid?).must_equal false
    end
  end

  # it "is invalid if username already exists" do
  #   new_user = User.new(username:'Username')
  #
  #   expect(new_user.valid?).must_equal false
  # end

  describe "relationships" do

    it "can have many votes" do
      user1 = users(:user1)
      expect(user1.votes.count).must_equal 2
  end

  end
end
