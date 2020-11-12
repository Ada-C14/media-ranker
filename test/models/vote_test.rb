require "test_helper"

describe Vote do
  let (:new_user) {
    User.create(username: "New User")
  }
  let (:new_work) {
    Work.create(
        category: 'book',
        title: "New Book",
        creator: "New Author",
        publication_year: 2019
    )
  }
  let (:new_vote) {
    Vote.new(
        user: new_user,
        work: new_work
    )
  }

  describe 'initialize' do
    it 'can be initialized' do
      expect(new_vote.valid?).must_equal true
    end

    it 'will have the required fields' do
      new_vote.save
      vote = Vote.find_by(user: new_user)

      [:user, :work].each do |field|
        expect(vote).must_respond_to field
      end
    end
  end

  describe 'validations' do
    it 'is valid for a novel work/user combination' do
      vote = Vote.new(user: users(:user3), work: works(:movie))

      expect(vote.valid?).must_equal true
    end

    it 'is invalid for a non-existent user' do
      new_vote.user = nil

      expect(new_vote.valid?).must_equal false
    end

    it 'is invalid for a non-existent work' do
      new_vote.work = nil

      expect(new_vote.valid?).must_equal false
    end

    it 'is invalid for an existing work/user combination' do
      vote = Vote.new(user: users(:user1), work: works(:book))

      expect(vote.valid?).must_equal false
    end
  end

  describe 'relations' do
    it 'belongs to a user and a work' do
      vote = votes(:vote1)

      expect(vote.user).must_be_instance_of User
      expect(vote.work).must_be_instance_of Work
    end

    it 'can set the user through "user"' do
      user = User.create(username: "user")
      vote = Vote.new
      vote.user = user

      expect(vote.user).must_equal user
      expect(vote.user_id).must_equal user.id
    end

    it 'can set the user through "user_id"' do
      user = User.create(username: "user")
      vote = Vote.new
      vote.user_id = user.id

      expect(vote.user_id).must_equal user.id
      expect(vote.user).must_equal user
    end

    it 'can set the work through "work"' do
      vote = Vote.new
      vote.work = new_work

      expect(vote.work).must_equal new_work
      expect(vote.work_id).must_equal new_work.id
    end

    it 'can get set the work through "work_id"' do
      vote = Vote.new
      vote.work_id = new_work.id

      expect(vote.work_id).must_equal new_work.id
      expect(vote.work).must_equal new_work
    end
  end
end
