require "test_helper"

describe User do

  describe "initiate" do
    it "can be instantiated" do
      # test each entry from users.yml file:
      users.each do |user|
        expect(user.valid?).must_equal true
      end
    end
  end

  describe "validations" do
    it "requires username (field)" do
      users.each do |user|
        expect(user).must_respond_to :username
      end
    end

    it "fails without a username (required field)" do
      invalid_user = User.new(username: "")
      expect(invalid_user.valid?).must_equal false
    end
  end

  it "usernames must be unique" do
    original_user = User.create(username: "meeseeks")
    new_user = User.create(username: "meeseeks")
    expect(original_user.valid?).must_equal true
    expect(new_user.valid?).must_equal false
  end

  describe 'relationships' do
    it 'can have one or more votes' do
      users.each do |user|
        works.each do |work|
          vote = Vote.create(user_id: user.id, work_id: work.id)
          expect(vote.valid?).must_equal true
          expect(user.votes.count).wont_be_nil
          expect(user.votes.count).must_be_instance_of Integer
        end
      end
    end
  end

end
