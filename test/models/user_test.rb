require "test_helper"

describe User do
  describe 'validation' do
    # before 'user' do
    #   @invalid_user = User.new()
    #
    # end
    it "can be instantiated" do
      # Assert
      user = users(:user_one)
      expect(user.valid?).must_equal true
    end

    # it 'does not instantiate given an invalid user' do
    #
    #   expect(@invalid_user.valid?).must_equal false
    # end
  end

  describe 'relationships' do
    it 'can find find all the votes a user has made' do
      user = User.all.first
      total_votes = user.votes
      total_votes.each do |vote|
        unless vote == nil
          expect(vote).must_be_instance_of Vote
          expect(user.id).must_equal vote.id
        end
      end
    end
    it 'can find the work a user has voted on' do
      user = User.all.first
      user_works = user.works
      user_works.each do |work|
          expect(work).must_be_instance_of Work
          expect(work.title).must_equal "Kreb-Full-o Been"
      end
    end
  end

end
