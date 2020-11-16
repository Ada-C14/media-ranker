require "test_helper"

describe User do
  let (:new_user) {
    User.new(username: "potato")
  }

  it "can be instantiated" do
    expect(new_user.valid?).must_equal true
  end

  it "wont allow a new user to be created without a username" do
    new_user.username = nil

    expect(new_user.valid?).must_equal false
  end

  describe "relationships" do
    it "has many votes" do
      work = Work.create(category: "Book", title: "Bluebeard", creator: "Kurt Vonnegut", publication_year: 1979, description: "haven't finished this one yet")
      work2 = Work.create(category: "Book", title: "Blue", creator: "Kurt Vonnegut", publication_year: 1979, description: "haven't finished this one yet")
      user = User.create(username: "test")
      Vote.create(work_id: work[:id],user_id: user[:id])
      Vote.create(work_id: work2[:id],user_id: user[:id])

      expect(user.votes.count).must_equal 2
    end
  end
end
