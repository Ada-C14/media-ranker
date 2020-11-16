require "test_helper"

describe User do
  before do
    @user1 = users(:bob)
    @user2 = users(:linda)
    @user3 = users(:louise)
    @user4 = users(:gene)
    @user5 = users(:tina)
  end

  it "can be instantiated" do
    [@user1, @user2, @user3, @user4, @user5].each do |user|
      expect(user.valid?).must_equal true
    end
  end

  it "will have the required fields" do
    [@user1, @user2, @user3, @user4, @user5].each do |user|
      expect(user).must_respond_to :id
      expect(user).must_respond_to :name
      expect(user).must_respond_to :created_at
      expect(user).must_respond_to :updated_at
    end
  end

  describe "validations" do
    it "user is valid if name is present" do
      new_user = User.create(name: "Leeroy Jenkins")

      expect(new_user.valid?).must_equal true
    end

    it "user is not valid if name is nil" do
      @user1.name = nil

      expect(@user1.valid?).must_equal false
      expect(@user1.errors.messages).must_include :name
      expect(@user1.errors.messages[:name]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    it "user can have many votes" do
      assert_operator @user1.votes.count, :>, 1

      @user1.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
end
