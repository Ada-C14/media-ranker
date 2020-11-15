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

end
