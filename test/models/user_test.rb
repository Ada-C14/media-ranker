require "test_helper"

describe User do
  describe "validation" do
      it "is invalid without a name" do
        #arrange
        user = users(:incognito)
        # act
        user.name = nil
        # assert
        expect(user.valid?).must_equal false
      end
  end

  describe "relations"  do
    it "has many votes" do
      #arrange
          work = works(:metallica)
          work_2 = works(:adele)
          user = users(:incognito)

      #act+assert
          vote_1 = Vote.create(work_id: work.id, user_id: user.id)
          vote_2 = Vote.create(work_id: work_2.id, user_id: user.id)
          expect(user.votes.length).must_equal 2
    end
  end

end
