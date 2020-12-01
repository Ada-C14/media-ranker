require "test_helper"

describe User do
  it "can be instantiated" do
    new_user = User.create(name: "Third User")

    expect(new_user.valid?).must_equal true
  end

  it "will have the required fields" do
    users = User.all

    users.each do |user|
      expect(user).must_respond_to :name
      expect(user).must_be_instance_of User
    end
  end

  describe 'relations' do
    it "can have many votes" do
      user = users(:user1)

      expect(user.votes.count).must_equal 2
      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it "has many works through votes" do
      user = users(:user1)

      user.votes.each do |vote|
        expect(vote.work).must_be_instance_of Work
      end
    end
  end

  describe 'validation' do
    it "must have a name" do
      user = User.first

      expect(user.valid?).must_equal true
      expect(user.name).must_equal users(:user1).name
    end

    it "must raise errors for invalid name" do
      user = users(:user1)
      user.name = nil

      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :name
      expect(user.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "name must be unique" do
      new_user = User.create(name: "Second User")

      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :name
      expect(new_user.errors.messages[:name]).must_equal ["has already been taken"]
    end
  end
end
