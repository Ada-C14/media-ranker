require "test_helper"

describe User do
  let (:new_user) { User.create!(name: "Kobi") }

  it "can be instantiated" do
    # assert
    expect(new_user.valid?).must_equal true
  end

  describe "validations" do
    it "is valid when there is a name" do
      # act & assert
      expect(new_user.valid?).must_equal true
    end

    it "is invalid when there is no name" do
      # arrange
      new_user.name = nil

      # assert
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :name
      expect(new_user.errors.messages[:name]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    it "can have many votes" do
      # arrange
      work_one = Work.create!(category: "movie", title: "Get Out", creator: "Jordan Peele", publication_year: 2017, description: "A Scarey and Funny movie")
      work_two = Work.create!(category: "book", title: "Becoming", creator: "Michelle Obama", publication_year: 2018, description: "Life")

      vote_1 = Vote.create!(user_id: new_user.id, work_id: work_one.id)
      vote_2 = Vote.create!(user_id: new_user.id, work_id: work_two.id)
      # assert
      expect(new_user.votes.count).must_equal 2
      expect(new_user.votes.first).must_be_instance_of Vote
    end
  end
end
