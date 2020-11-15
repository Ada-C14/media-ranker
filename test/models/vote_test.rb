require "test_helper"

describe Vote do
  before do
    @new_user = User.create!(name: "Kobi")
    @new_work = Work.create!(category: "book", title: "The Biggest Bluff", creator: "Maria Konnikova", publication_year: 2020, description: "SIY")
    @new_vote = Vote.new(work_id: @new_work.id, user_id: @new_user.id)
  end

  it "can be instantiated" do
    expect(@new_vote.valid?).must_equal true
  end

  it "will have the required fields" do
    # Arrange
    # @new_vote.save
    # vote = Vote.first
    [:work_id, :user_id].each do |field|
      # Assert
      expect(@new_vote).must_respond_to field
    end
  end
  
  describe "validations" do
    it "is valid when there is a user" do
      expect(@new_user.valid?).must_equal true
    end

    it "requires an user_id" do
      @new_vote.user_id = nil
      expect(@new_vote.valid?).must_equal false
      expect(@new_vote.errors.messages).must_include :user_id
      expect(@new_vote.errors.messages[:user_id]).must_equal ["can't be blank"]
    end

    it "returns true when given a valid user_id" do
      @new_vote.user_id = @new_user.id
      expect(@new_vote.valid?).must_equal true
    end

    it "returns true when given a valid work_id" do
      @new_vote.work_id = @new_work.id
      expect(@new_vote.valid?).must_equal true
    end

  end
  describe "relationships" do
  end



  
end
