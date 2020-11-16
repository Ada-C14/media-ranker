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
    end
  end

  describe 'relations' do
    it 'can set the user through user' do
      # Create two models
      user = User.create!(name: "test user")
      vote = Vote.new(work_id: 1, user_id: 4)

      # Make the models relate to one another
      vote.user = user

      # author_id should have changed accordingly
      expect(vote.user).must_equal user
    end

    it 'can set the user through "user_id"' do
      # Create two models
      user = User.create!(name: "test user")
      vote = Vote.new(work_id: 1, user_id: 4)

      # Make the models relate to one another
      vote.user_id = user.id

      # author_id should have changed accordingly
      expect(vote.user_id).must_equal user.id
    end

    it 'can set the work through work' do
      # Create two models
      work = works(:world)
      vote = Vote.new(work_id: 1, user_id: 4)

      # Make the models relate to one another
      vote.work = work

      # author_id should have changed accordingly
      expect(vote.work).must_equal work
    end

    it 'can set the work through "work_id"' do
      # Create two models
      work = works(:world)
      vote = Vote.new(work_id: 1, user_id: 4)

      # Make the models relate to one another
      vote.work_id = work.id

      # author_id should have changed accordingly
      expect(vote.work_id).must_equal work.id
    end

    it "belongs to one user" do
      vote = votes(:first)
      expect(vote.user).must_be_instance_of User
      expect(vote.user).must_equal users(:harry)
    end

    it "belongs to one work" do
      vote = votes(:first)
      expect(vote.work).must_be_instance_of Work
      expect(vote.work).must_equal works(:gods)
    end
  end
end
