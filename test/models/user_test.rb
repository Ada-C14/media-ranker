require "test_helper"

describe User do
  before do
    @user = User.new(
        {
            username: "Mona"
        }
    )
  end

  it "has the required field" do
    @user.save
    user = User.find_by(username: "Mona")
    [:username].each do |field|
      expect(user).must_respond_to field
    end
  end

  describe "Validations" do
    it 'is valid when all fields are present' do
      @user.save
      result = @user.valid?
      expect(result).must_equal true
    end

    it 'is invalid without a username' do
      @user.username = nil
      @user.save
      result = @user.valid?
      expect(result).must_equal false
      expect(@user.errors.messages).must_include :username
      expect(@user.errors.messages[:username]).must_include "can't be blank"
    end

    it 'username validation when the title already exists' do
      @user.save
      test_new_user = User.new({ username: "Mona" })

      test_new_user.save
      expect(test_new_user.valid?).must_equal false
      expect(test_new_user.errors.messages).must_include :username
      expect(test_new_user.errors.messages[:username]).must_include "has already been taken"
    end
  end
  describe "relations" do
    it "has many votes" do
      test_user = users(:user_2)
      expect(test_user.votes.count).must_equal 3
      @user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it "has many works through votes" do
      user = users(:user_1)
      expect(user.works.count).must_equal 6
      user.works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end
  end
end
