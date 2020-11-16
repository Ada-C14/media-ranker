require "test_helper"

describe User do

  let (:new_user) {
    User.create(username: "Alice")
  }

  let (:new_work) {
    Work.create(category: "album", title: "Samba", creator: "Alice B.", publication_year: 2020, description: "Brazilian Samba")
  }

  let (:vote_1) {
    Vote.create(user_id: new_user.id, work_id: new_work.id)
  }

  let (:vote_2) {
    Vote.create(user_id: new_user.id, work_id: new_work.id)
  }

  it "can be instantiated" do
    #Assert
    expect(new_user.valid?).must_equal true
  end

  it "will have the requered fields" do
    # Arrange
    new_user.save
    user = User.first
    [:username].each do |field|

    # Assert
    expect(user).must_respond_to field
    end
  end

  describe "validations" do
    it "It must to have a username" do
      new_user.username = nil

      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :username
    end
  end

  describe "custom methods" do
    it "total votes: returns 0 if no votes" do
      new_user
      expect(new_user.votes.count).must_equal 0
    end

    it "total of votes: returns total if valid votes" do
      new_user
      vote_1
      vote_2

      expect(new_user.votes.count).must_equal 2
    end
  end
end
