require "test_helper"

describe User do
  let(:user){
    User.new(username: "AliceB")
  }

  let (:work) {
    Work.new(category: "movie", title: "Holidate", creator: "Alice B.", publication_year: 2020, description: "A love history")
  }

  let (:vote_1){
    Vote.create(user_id: user.id, work_id: work.id)
  }

  let (:vote_2){
    Vote.create(user_id: user.id, work_id: work.id)
  }

  it "can be instantiated" do
    #Assert
    expect(user.valid?).must_equal true
  end

  it "will have the requeired fields" do
    # Arrange
    user.save
    user = User.first
    [:username].each do |field|

    # Assert
    expect(user).must_respond_to field
    end
  end

  # describe "relationships" do
  #   it "can have many votes" do
  #     # Arrange
  #     user.save!
  #     vote_1
  #     vote_2
  #
  #     # Assert
  #     expect(user.votes.count).must_equal 2
  #     user.votes.each do |vote|
  #       expect(vote).must_be_instance_of User
  #     end
  #   end
  # end

  # describe 'relations' do
  #   it 'can set the works through votes' do
  #     # Create two models
  #     user = User.create!(username: "test username")
  #     work = Work.new(title: "test work")
  #
  #     # Make the models relate to one another
  #     work.user=user
  #
  #     # author_id should have changed accordingly
  #     expect(work.user_id).must_equal user.id
  #   end
  #
  #   it 'can set the user through "user_id"' do
  #     # Create two models
  #     user = User.create!(username: "test username")
  #     work = Work.new(title: "test work")
  #
  #     # Make the models relate to one another
  #
  #     work.user_id = user.id
  #
  #     # author should have changed accordingly
  #     expect(work.user).must_equal user
  #   end
  # end

  describe "validations" do
    it "It must to have a username" do
      user.username = nil
      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :username
      expect(work.errors.messages[:username]).must_equal ["can't be blank"]
    end
  end
end
