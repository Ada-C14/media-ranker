require "test_helper"

describe Vote do
  describe "validation" do
    it "doesn't allow user to vote twice for 1 work" do
      #arrange
      user = users(:incognito)
      work = works(:metallica)
      vote = Vote.create(work_id: work.id, user_id: user.id)
      vote_2 = Vote.create(work_id: work.id, user_id: user.id)
      #act+assert
      expect(vote.valid?).must_equal true
      expect(vote_2.valid?).must_equal false
      expect(Vote.all.length).must_equal 1
    end
  end

  describe "relations" do
    it "belongs to a user" do
      #arrange
      user = users(:incognito)
      work = works(:metallica)
      vote = Vote.create(work_id: work.id, user_id: user.id)
      # act+assert
      expect(vote.user_id).must_equal users(:incognito).id
    end

    it "belongs to a work" do
      #arrange
      user = users(:incognito)
      work = works(:metallica)
      vote = Vote.create(work_id: work.id, user_id: user.id)
      # act+assert
      expect(vote.work_id).must_equal works(:metallica).id
    end
  end

end
