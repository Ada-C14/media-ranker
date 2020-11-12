require "test_helper"

describe Vote do
  let(:new_work) {
    Work.new(category: "book", title: "test title", creator: "test creator", publication_year: 2020, description: "test description")
  }

  it "can be instantiated" do
    # Arrange
    new_work.save
    user = User.create!(username: "test user")
    vote = Vote.create!(user_id: user.id , work_id: new_work.id)

    # Assert
    expect(vote.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    new_work.save
    user = User.create!(username: "test user")
    vote = Vote.create!(user_id: user.id , work_id: new_work.id)

    # Assert
    [:work_id, :user_id].each do |field|
      expect(vote).must_respond_to field
    end
  end

  describe "validations" do
    it "does not allow a user to vote for the same work twice" do
      # Arrange
      new_work.save
      user = User.create!({username: "test user"})
      vote_1 = Vote.create(user_id: user.id, work_id: new_work.id)
      vote_2 = Vote.create(user_id: user.id, work_id: new_work.id)

      # Assert
      expect(vote_1.valid?).must_equal true
      expect(vote_2.valid?).must_equal false
      expect(vote_2.errors.messages).must_include :user_id
      expect(vote_2.errors.messages[:user_id]).must_equal ["user: has already voted for this work"]
    end
  end

  describe "relationships" do
    it "belongs to a user" do
      # Arrange
      new_work.save
      user = User.create!({username: "test user"})
      vote = Vote.create!(user_id: user.id, work_id: new_work.id)

      # Assert
      expect(vote.user_id).must_equal user.id
      expect(vote.user).must_equal user

    end

    it "belongs to a work" do
      # Arrange
      new_work.save
      user = User.create!({username: "test user"})
      vote = Vote.create!(user_id: user.id, work_id: new_work.id)

      # Assert
      expect(vote.work_id).must_equal new_work.id
      expect(vote.work).must_equal new_work
    end
  end
end
