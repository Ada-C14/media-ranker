require "test_helper"

describe Vote do
  let(:new_work) {
    Work.new(category: "book", title: "test title", creator: "test creator", publication_year: 2020, description: "test description")
  }

  describe "relationships" do
    it "belongs to a user" do
      # Arrange
      new_work.save
      user = User.create!({username: "test user"})
      vote = Vote.create!(user_id: user.id, work_id: new_work.id)

      # Act/Assert
      expect(vote.user_id).must_equal user.id
      expect(vote.user).must_equal user

    end

    it "belongs to a work" do
      # Arrange
      new_work.save
      user = User.create!({username: "test user"})
      vote = Vote.create!(user_id: user.id, work_id: new_work.id)

      # Act/Assert
      expect(vote.work_id).must_equal new_work.id
      expect(vote.work).must_equal new_work
    end
  end
end
