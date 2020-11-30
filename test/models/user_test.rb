require "test_helper"

describe User do
  let(:user) {
    User.new(name:"Test User")
  }
  it 'can be instantiated' do
    expect(user.valid?).must_equal true
  end

  it "will have the required fields" do
    user.save

    expect(user).must_respond_to :name
  end

  describe "relationships" do
    it 'can have many votes' do
      user = users(:first)
      votes = user.votes
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "validations" do
    it 'must have a name' do
      new_user = User.new(name: nil)
      new_user.save
      expect(new_user.valid?).must_equal false
    end

    it 'cannot have the same name twice' do
      user = User.new(name: 'first')
      user_two = User.new(name: 'first')

      expect(user_two.valid?).must_equal false
    end
  end

  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
