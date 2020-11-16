require "test_helper"

describe Vote do
  before do
    @work = Work.create(category: "book", title: "Pachinko", creator: "Min Jin Lee", publication_year: 2017, description: "A saga about four generations of a poor Korean immigrant family fight to control their destiny in 20th-century Japan, exiled from their home.")
    @user = User.create(username: "beauttie")
    @new_vote = Vote.new(work_id: @work.id, user_id: @user.id)
  end

  it "can be instantiated" do
    expect(@new_vote.valid?).must_equal true
  end

  it "will have the required fields" do
    @new_vote.save
    vote = Vote.first

    [:work_id, :user_id].each do |field|
      expect(vote).must_respond_to field
    end
  end
end
