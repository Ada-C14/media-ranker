require "test_helper"

describe Vote do
  let (:new_user) {
    User.new(username: "New User")
  }
  let (:new_work) {
    Work.new(
        category: book,
        title: "New Book",
        author: "New Author"
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
      vote = find_by(user: new_user)

      [:user, :work].each do |field|
        expect(vote).must_respond_to field
      end
    end
  end
end
