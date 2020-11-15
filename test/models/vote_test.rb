require "test_helper"

describe Vote do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  #

  it "can be instantiated" do
    # Assert
    work = works(:gods)
    user = users(:ron)

    vote1 = Vote.create(user_id: user.id, work_id: work.id)
    expect(vote1.valid?).must_equal true

    vote2 = votes(:first)
    expect(vote2.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    vote = votes(:third)
    [:work_id, :user_id].each do |field|

      # Assert
      expect(vote).must_respond_to field
    end
  end

  describe "validations" do
    it "will not let user vote for work more than once" do
      # Arrange
      duplicate_vote = Vote.create(work_id: 1, user_id: 1)

      # Assert
      expect(duplicate_vote.valid?).must_equal false
      expect(duplicate_vote.errors.messages).must_include :work_id
      expect(duplicate_vote.errors.messages[:work_id]).must_equal ["User cannot upvote work more than once"]
    end


  end

end
