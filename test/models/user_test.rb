require "test_helper"

describe User do
  before do
    @user = users(:user1)
  end

  let (:new_user) {
    User.new(username: "user")
  }
  it "can be instantiated" do
    # Assert
    expect(new_user.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_user.save
    user = User.first
    # Assert
    expect(user).must_respond_to :username
  end

  describe "relations" do
    it 'can have many Votes' do
      work = works(:album)

      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
      expect(work.votes.count).must_equal 3
    end
  end

  describe "validations" do
    it "must have a username" do
      # Arrange
      new_user.username = nil

      # Assert
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :username
      expect(new_user.errors.messages[:username]).must_equal ["can't be blank"]
    end

    it 'must have the required fields present' do
      result = @user.valid?
      expect(result).must_equal true
    end
  end
end
