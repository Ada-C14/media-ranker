require "test_helper"

describe Vote do
  before do
    @vote = votes(:vote1)
  end

  let (:new_user) {
    User.create(username: "user")
  }
  let (:new_work) {
    Work.create(category: "book",
                title: "Test Book")
  }
  let (:new_vote) {
    Vote.new(user: new_user,
             work: new_work)
  }

  it "can be instantiated" do
    expect(new_vote.valid?).must_equal true
  end

  it 'will have the required fields' do
    new_vote.save
    vote = Vote.find_by(user: new_user)

    [:user, :work].each do |field|
      expect(vote).must_respond_to field
    end
  end

  describe 'relations' do

    it 'belongs to one user' do
      expect(@vote.user).must_be_instance_of User
      expect(@vote.user).must_equal users(:user1)
    end

    it "belongs to one work" do
      expect(@vote.work).must_be_instance_of Work
      expect(@vote.work).must_equal works(:book)
    end
  end


  describe 'validations' do

    it 'prevents multiple votes for a work by the same user' do
      vote3 = Vote.create(work_id: @vote.work_id, user_id: @vote.user_id)

      expect(vote3.valid?).must_equal false
      expect(vote3.errors.messages).must_include :work_id
      expect(vote3.errors.messages[:work_id]).must_equal ["has already been taken"]

    end

    it 'is invalid for a non-existent user' do
      new_vote.user = nil

      expect(new_vote.valid?).must_equal false
    end

    it 'is invalid for a non-existent work' do
      new_vote.work = nil

      expect(new_vote.valid?).must_equal false
    end
  end
end
