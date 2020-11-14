require "test_helper"

describe Vote do

  before do
    @user = users(:user_3)
    @work = works(:work_6)
    @vote = Vote.new(
        {
            work_id: @work.id,
            user_id: @user.id
        }
    )
  end

  it "will have the required fields" do
    @vote.save
    test_vote = Vote.first
    [:user_id, :work_id].each do |field|
      expect(test_vote).must_respond_to field
    end
  end

  describe 'validations' do
    it 'is valid when all fields are present' do
      @vote.save
      expect(@vote.valid?).must_equal true
    end

    it 'fails validation when the work_id already exists' do
      @vote.save
      new_vote = Vote.new(
          {
              work_id: @work.id,
              user_id: @user.id
          }
      )
      new_vote.save
      expect(new_vote.valid?).must_equal false
      expect(new_vote.errors.messages).must_include :work_id
      expect(new_vote.errors.messages[:work_id]).must_include "has already been taken"
    end
  end

  describe "relations" do
    it "has one work and one user" do
      @vote.save
      expect(@vote.work_id).must_equal @work.id
      expect(@vote.user_id).must_equal @user.id
    end
  end
end



