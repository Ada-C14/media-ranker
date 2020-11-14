require "test_helper"

describe Vote do
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


  describe 'validations' do
    it 'prevents multiple votes for a work by the same user' do


    end
  end
end
