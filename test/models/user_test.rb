require "test_helper"

describe User do
  let(:new_user){
    User.new(username: 'test_user')
  }

  describe 'Relationships' do
    it 'can have many votes through different works' do
      skip
      new_user.save
      work1 = works(:work1)
      work2 = works(:work2)
      vote1 = Vote.create(work_id: work1.id, user_id: new_user.id)
      vote2 = Vote.create(work_id: work2.id, user_id: new_user.id)

      expect(new_user.votes.count).must_equal 2
      new_user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it 'can have many works through votes' do
      new_user.save
      work1 = works(:work1)
      work2 = works(:work2)
      vote1 = Vote.create(work_id: work1.id, user_id: new_user.id)
      vote2 = Vote.create(work_id: work2.id, user_id: new_user.id)

      expect(new_user.works.count).must_equal 2
      new_user.works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end
  end

  describe 'Validations' do
    before do
      @user = new_user
    end

    it 'is valid when all fields are filled' do
      expect(@user.valid?).must_equal true
    end

    it 'fails validation when there is no username' do
      @user.username = nil

      expect(@user.valid?).must_equal false
    end

  end
end
