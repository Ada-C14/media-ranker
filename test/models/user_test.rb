require "test_helper"

describe User do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  #

  it "can be instantiated" do
    # Assert
    #
    user1 = User.create(name: "test")
    expect(user1.valid?).must_equal true

    user2 = users(:ron)
    expect(user2.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange

    user = User.first
    [:name].each do |field|

      # Assert
      expect(user).must_respond_to field
    end
  end

  describe "validations" do
    it "must have a name" do
      # Arrange
      user = User.create(name: "to_delete")
      user.name = nil

      # Assert
      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :name
      expect(user.errors.messages[:name]).must_equal ["can't be blank"]
    end
  end

  describe 'relations' do
    it 'has many votes' do
      user = users(:harry)
      vote = Vote.create!(work_id: 3, user_id: 1)

      expect(user.votes.first).must_be_instance_of Vote
      expect(user.votes.count > 1).must_equal true
    end

    it 'has many users through votes' do
      user = users(:harry)
      vote = Vote.create!(work_id: 3, user_id: 1)

      expect(user.works.first).must_be_instance_of Work
      expect(user.works.count > 1).must_equal true
    end
  end
end
