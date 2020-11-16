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

  describe 'validations' do
    it 'is invalid if user votes for the same work more than once' do
      @new_vote.save
      another_vote = Vote.new(work_id: @work.id, user_id: @user.id)

      expect(another_vote.valid?).must_equal false
      expect(another_vote.errors.messages).must_include :work_id
      expect(another_vote.errors.messages[:work_id]).must_equal ["User has already voted for this work"]
    end
  end

  describe 'relations' do
    it "belongs to a work" do
      expect(@new_vote.work).must_equal @work
    end

    it "can set the work" do
      new_work = Work.new(category: "movie", title: "Us and Them", creator: "Rene Liu", publication_year: 2018, description: "Chinese romantic drama film")
      @new_vote.work = new_work

      expect(@new_vote.work_id).must_equal new_work.id
    end

    it "belongs to a user" do
      expect(@new_vote.user).must_equal @user
    end

    it "can set the user" do
      new_user = User.new(username: "not_beauttie")
      @new_vote.user = new_user

      expect(@new_vote.user_id).must_equal new_user.id
    end
  end
end
