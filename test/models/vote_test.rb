require "test_helper"

describe Vote do
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
    it 'belongs to many works' do
      work = works(:work1)

      expect(work.votes.count).must_equal 2
      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it 'belongs to many users' do
      user = users(:user1)

      expect(user.votes.count).must_equal 2
      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
end
