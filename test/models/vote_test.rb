require "test_helper"

describe Vote do

  let (:new_work) {
    Work.create(category: "album", title: "Samba", creator: "Alice B.", publication_year: 2020, description: "Brazilian Samba")
  }

  let (:new_user) {
    User.create(username: "Alice")
  }

  let (:vote_1) {
    Vote.create(user_id: new_user.id, work_id: new_work.id)
  }

  describe "relationships" do

    it "belongs to a user and a work" do
      # Arrange
      new_user.save
      new_work.save
      vote_1

      # Assert
      expect(User.find_by(id: vote_1.user_id)).must_be_instance_of User
      expect(Work.find_by(id: vote_1.work_id)).must_be_instance_of Work
    end
  end

  describe "validations" do

    it " is valid with a user and work" do
      result = vote_1.valid?
      expect(result).must_equal true
    end

    it "must have a user" do
      vote_1.user = nil

      result = vote_1.valid?
      expect(result).must_equal false
    end

    it "must have a work" do
      vote_1.work = nil

      result = vote_1.valid?
      expect(result).must_equal false
    end
  end
end
