require "test_helper"

describe Vote do
  let(:new_vote){
    work = works(:dead_alive)
    user = User.new(name: "vvv")
    Vote.new(work: work, user: user)
  }
  describe "relationships" do
    it "can have a work" do
      # Arrange
      new_vote.save

      # Assert
      expect(new_vote.work).must_be_instance_of Work
    end

    it "can have a passenger" do
      # Arrange
      new_vote.save

      # Assert
      expect(new_vote.user).must_be_instance_of User
    end
  end
end
